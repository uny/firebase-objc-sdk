import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
actor LockedAsyncIterator<Element: Sendable> {
    private let nextElement: @Sendable () async throws -> Element?
    private var pendingContinuations: [CheckedContinuation<Element?, Error>] = []
    private var isReading = false
    private var finished = false

    /// Constructs an iterator that pulls elements from the given closure.
    ///
    /// The closure is invoked at most once at a time and is responsible for advancing whatever
    /// underlying source it captures. Callers that need to wrap a non-`Sendable` upstream iterator
    /// should hold it inside an `@unchecked Sendable` reference type and call into it from the
    /// closure.
    init(next nextElement: @escaping @Sendable () async throws -> Element?) {
        self.nextElement = nextElement
    }

    /// Convenience init for the common case of wrapping an `AsyncThrowingStream` iterator.
    init(_ iterator: AsyncThrowingStream<Element, Error>.Iterator) {
        let box = StreamIteratorBox(iterator)
        self.nextElement = { try await box.next() }
    }

    private final class StreamIteratorBox: @unchecked Sendable {
        var iterator: AsyncThrowingStream<Element, Error>.Iterator

        init(_ iterator: AsyncThrowingStream<Element, Error>.Iterator) {
            self.iterator = iterator
        }

        func next() async throws -> Element? {
            try await iterator.next()
        }
    }

    func next() async throws -> Element? {
        try await withCheckedThrowingContinuation { continuation in
            pendingContinuations.append(continuation)
            drainQueue()
        }
    }

    private func drainQueue() {
        guard !isReading, !pendingContinuations.isEmpty else { return }
        isReading = true
        let continuation = pendingContinuations.removeFirst()

        if finished {
            continuation.resume(returning: nil)
            isReading = false
            drainQueue()
            return
        }

        Task {
            do {
                let value = try await self.nextElement()
                if value == nil { self.finished = true }
                continuation.resume(returning: value)
            } catch {
                self.finished = true
                continuation.resume(throwing: error)
                for pending in self.pendingContinuations {
                    pending.resume(throwing: error)
                }
                self.pendingContinuations.removeAll()
            }
            self.isReading = false
            self.drainQueue()
        }
    }
}
