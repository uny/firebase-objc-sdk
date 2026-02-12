import XCTest
import FirebaseAILogic
@testable import FirebaseAILogicObjC

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
final class StreamTests: XCTestCase {

    // MARK: - ContentStream

    func testEmptyContentStreamReturnsNil() async throws {
        let stream = AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error> { continuation in
            continuation.finish()
        }
        let contentStream = ContentStream(stream: stream)
        let result = try await contentStream.next()
        XCTAssertNil(result, "An empty stream should return nil on first next()")
    }

    func testContentStreamPropagatesError() async {
        let expectedError = NSError(domain: "test", code: 1, userInfo: nil)
        let stream = AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error> { continuation in
            continuation.finish(throwing: expectedError)
        }
        let contentStream = ContentStream(stream: stream)

        do {
            _ = try await contentStream.next()
            XCTFail("Expected an error to be thrown")
        } catch {
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "test")
            XCTAssertEqual(nsError.code, 1)
        }
    }

    func testContentStreamConcurrentAccess() async throws {
        let stream = AsyncThrowingStream<FirebaseAILogic.GenerateContentResponse, Error> { continuation in
            continuation.finish()
        }
        let contentStream = ContentStream(stream: stream)

        // Multiple concurrent calls should all safely return nil
        async let r1 = contentStream.next()
        async let r2 = contentStream.next()
        async let r3 = contentStream.next()

        let results = try await [r1, r2, r3]
        for result in results {
            XCTAssertNil(result)
        }
    }
}
