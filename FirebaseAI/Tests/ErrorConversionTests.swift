import Foundation
import Testing
@testable import FirebaseAILogicObjC

@Suite struct ErrorConversionTests {

    // MARK: - GenerateContentError

    @Test func generateContentErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 42, userInfo: nil)
        let result = GenerateContentError.from(error)
        #expect(result == nil, "Unrelated NSError should not produce a GenerateContentError")
    }

    // MARK: - ImagenImagesBlockedError

    @Test func imagenImagesBlockedErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 1, userInfo: nil)
        let result = ImagenImagesBlockedError.from(error)
        #expect(result == nil, "Unrelated NSError should not produce an ImagenImagesBlockedError")
    }

    // MARK: - Live Session Errors

    #if !os(watchOS)
    @Test func liveSessionUnsupportedMessageErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 1, userInfo: nil)
        let result = LiveSessionUnsupportedMessageError.from(error)
        #expect(result == nil, "Unrelated NSError should not produce a LiveSessionUnsupportedMessageError")
    }

    @Test func liveSessionLostConnectionErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 1, userInfo: nil)
        let result = LiveSessionLostConnectionError.from(error)
        #expect(result == nil, "Unrelated NSError should not produce a LiveSessionLostConnectionError")
    }

    @Test func liveSessionUnexpectedClosureErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 1, userInfo: nil)
        let result = LiveSessionUnexpectedClosureError.from(error)
        #expect(result == nil, "Unrelated NSError should not produce a LiveSessionUnexpectedClosureError")
    }

    @Test func liveSessionSetupErrorFromUnrelatedNSError() {
        let error = NSError(domain: "com.example.test", code: 1, userInfo: nil)
        let result = LiveSessionSetupError.from(error)
        #expect(result == nil, "Unrelated NSError should not produce a LiveSessionSetupError")
    }
    #endif
}
