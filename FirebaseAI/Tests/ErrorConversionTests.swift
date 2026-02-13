import XCTest
@testable import FirebaseAILogicObjC

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
final class ErrorConversionTests: XCTestCase {

    // MARK: - GenerateContentError

    func testGenerateContentErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 42, userInfo: nil)
        let result = GenerateContentError.from(error)
        XCTAssertNil(result, "Unrelated NSError should not produce a GenerateContentError")
    }

    // MARK: - ImagenImagesBlockedError

    func testImagenImagesBlockedErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 1, userInfo: nil)
        let result = ImagenImagesBlockedError.from(error)
        XCTAssertNil(result, "Unrelated NSError should not produce an ImagenImagesBlockedError")
    }

    // MARK: - Live Session Errors

    #if !os(watchOS)
    func testLiveSessionUnsupportedMessageErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 1, userInfo: nil)
        let result = LiveSessionUnsupportedMessageError.from(error)
        XCTAssertNil(result, "Unrelated NSError should not produce a LiveSessionUnsupportedMessageError")
    }

    func testLiveSessionLostConnectionErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 1, userInfo: nil)
        let result = LiveSessionLostConnectionError.from(error)
        XCTAssertNil(result, "Unrelated NSError should not produce a LiveSessionLostConnectionError")
    }

    func testLiveSessionUnexpectedClosureErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 1, userInfo: nil)
        let result = LiveSessionUnexpectedClosureError.from(error)
        XCTAssertNil(result, "Unrelated NSError should not produce a LiveSessionUnexpectedClosureError")
    }

    func testLiveSessionSetupErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 1, userInfo: nil)
        let result = LiveSessionSetupError.from(error)
        XCTAssertNil(result, "Unrelated NSError should not produce a LiveSessionSetupError")
    }
    #endif
}
