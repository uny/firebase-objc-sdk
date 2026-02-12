import FirebaseAILogic
import Foundation

/// A stream of messages from the server during a live session.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerMessageStream)
public final class LiveServerMessageStream: NSObject, @unchecked Sendable {
    private let iterator: LockedAsyncIterator<FirebaseAILogic.LiveServerMessage>

    init(stream: AsyncThrowingStream<FirebaseAILogic.LiveServerMessage, Error>) {
        self.iterator = LockedAsyncIterator(stream.makeAsyncIterator())
        super.init()
    }

    /// Returns the next message in the stream, or `nil` when the stream is finished.
    @objc public func next() async throws -> LiveServerMessage? {
        guard let message = try await iterator.next() else { return nil }
        return LiveServerMessage(value: message)
    }
}
