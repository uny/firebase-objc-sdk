import Foundation
import Testing
@testable import FirebaseAILogicObjC

@Suite struct ErrorConversionTests {

    // MARK: - GenerativeModelError

    @Test func nsErrorFromUnknownErrorWrapsWithDomain() {
        let src = NSError(
            domain: "unrelated",
            code: 42,
            userInfo: [NSLocalizedDescriptionKey: "boom"]
        )
        let ns = GenerativeModelError.nsError(from: src)
        #expect(ns.domain == GenerativeModelError.domain)
        #expect(ns.code == GenerativeModelErrorCode.unknown.rawValue)
        #expect(ns.userInfo[GenerativeModelError.errorTypeKey] as? String == "unknown")
        let underlying = ns.userInfo[NSUnderlyingErrorKey] as? NSError
        #expect(underlying?.domain == "unrelated")
        #expect(underlying?.code == 42)
        #expect(ns.localizedDescription == "boom")
    }

    @Test func nsErrorFromOwnDomainIsIdempotent() {
        let src = NSError(
            domain: GenerativeModelError.domain,
            code: GenerativeModelErrorCode.internalError.rawValue,
            userInfo: [GenerativeModelError.errorTypeKey: "internalError"]
        )
        let ns = GenerativeModelError.nsError(from: src)
        #expect(ns === src)
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
