import Foundation
import Testing
import FirebaseAILogic
@testable import FirebaseAILogicObjC

@Suite struct StreamTests {

    // MARK: - ContentStream

    @Test func emptyContentStreamReturnsNil() async throws {
        let stream = AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error> { continuation in
            continuation.finish()
        }
        let contentStream = ContentStream(stream: stream)
        let result = try await contentStream.next()
        #expect(result == nil, "An empty stream should return nil on first next()")
    }

    @Test func contentStreamPropagatesError() async {
        let expectedError = NSError(domain: "test", code: 1, userInfo: nil)
        let stream = AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error> { continuation in
            continuation.finish(throwing: expectedError)
        }
        let contentStream = ContentStream(stream: stream)

        do {
            _ = try await contentStream.next()
            Issue.record("Expected an error to be thrown")
        } catch {
            let nsError = error as NSError
            #expect(nsError.domain == GenerativeModelError.domain)
            #expect(nsError.code == GenerativeModelErrorCode.unknown.rawValue)
            let underlying = nsError.userInfo[NSUnderlyingErrorKey] as? NSError
            #expect(underlying?.domain == "test")
            #expect(underlying?.code == 1)
        }
    }

    @Test func contentStreamConcurrentAccess() async throws {
        let stream = AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error> { continuation in
            continuation.finish()
        }
        let contentStream = ContentStream(stream: stream)

        async let result1 = contentStream.next()
        async let result2 = contentStream.next()
        async let result3 = contentStream.next()

        let results = try await [result1, result2, result3]
        for result in results {
            #expect(result == nil)
        }
    }
}
