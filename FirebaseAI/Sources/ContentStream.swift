import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBContentStream)
public final class ContentStream: NSObject {
    private let iterator: LockedIterator

    init(stream: AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error>) {
        self.iterator = LockedIterator(stream.makeAsyncIterator())
        super.init()
    }

    /// Returns the next response in the stream, or `nil` when the stream is finished.
    @objc public func next() async throws -> GenerateContentResponse? {
        guard let response = try await iterator.next() else { return nil }
        return GenerateContentResponse(value: response)
    }

    private actor LockedIterator {
        private let box: Box
        private var pendingContinuations: [CheckedContinuation<FirebaseAILogic.GenerateContentResponse?, Error>] = []
        private var isReading = false
        private var finished = false

        final class Box: @unchecked Sendable {
            var iterator: AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error>.Iterator

            init(_ iterator: AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error>.Iterator) {
                self.iterator = iterator
            }

            func next() async throws -> FirebaseAILogic.GenerateContentResponse? {
                try await iterator.next()
            }
        }

        init(_ iterator: AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error>.Iterator) {
            self.box = Box(iterator)
        }

        func next() async throws -> FirebaseAILogic.GenerateContentResponse? {
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
}
