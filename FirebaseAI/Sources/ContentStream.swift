import FirebaseAILogic
import Foundation

/// A stream of content generation responses.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBContentStream)
public final class ContentStream: NSObject, @unchecked Sendable {
    private let iterator: LockedAsyncIterator<FirebaseAILogic.GenerateContentResponse>

    init(stream: AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error>) {
        self.iterator = LockedAsyncIterator(stream.makeAsyncIterator())
        super.init()
    }

    /// Returns the next response in the stream, or `nil` when the stream is finished.
    @objc public func next() async throws -> GenerateContentResponse? {
        guard let response = try await iterator.next() else { return nil }
        return GenerateContentResponse(value: response)
    }
}
