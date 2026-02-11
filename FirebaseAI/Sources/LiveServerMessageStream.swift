import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerMessageStream)
public final class LiveServerMessageStream: NSObject {
    private let iterator: LockedIterator

    init(stream: AsyncThrowingStream<FirebaseAILogic.LiveServerMessage, Error>) {
        self.iterator = LockedIterator(stream.makeAsyncIterator())
        super.init()
    }

    /// Returns the next message in the stream, or `nil` when the stream is finished.
    @objc public func next() async throws -> LiveServerMessage? {
        guard let message = try await iterator.next() else { return nil }
        return LiveServerMessage(value: message)
    }

    private actor LockedIterator {
        private let box: Box

        final class Box: @unchecked Sendable {
            var iterator: AsyncThrowingStream<FirebaseAILogic.LiveServerMessage, Error>.Iterator

            init(_ iterator: AsyncThrowingStream<FirebaseAILogic.LiveServerMessage, Error>.Iterator) {
                self.iterator = iterator
            }

            func next() async throws -> FirebaseAILogic.LiveServerMessage? {
                try await iterator.next()
            }
        }

        init(_ iterator: AsyncThrowingStream<FirebaseAILogic.LiveServerMessage, Error>.Iterator) {
            self.box = Box(iterator)
        }

        func next() async throws -> FirebaseAILogic.LiveServerMessage? {
            try await box.next()
        }
    }
}
