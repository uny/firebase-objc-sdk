import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
actor LockedAsyncIterator<Element: Sendable> {
    private let box: Box
    private var pendingContinuations: [CheckedContinuation<Element?, Error>] = []
    private var isReading = false
    private var finished = false

    final class Box: @unchecked Sendable {
        var iterator: AsyncThrowingStream<Element, Error>.Iterator

        init(_ iterator: AsyncThrowingStream<Element, Error>.Iterator) {
            self.iterator = iterator
        }

        func next() async throws -> Element? {
            try await iterator.next()
        }
    }

    init(_ iterator: AsyncThrowingStream<Element, Error>.Iterator) {
        self.box = Box(iterator)
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
                let value = try await self.box.next()
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
