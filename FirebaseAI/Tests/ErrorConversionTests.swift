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
        let result = GenerativeModelError.nsError(from: src)
        #expect(result.domain == GenerativeModelError.domain)
        #expect(result.code == GenerativeModelErrorCode.unknown.rawValue)
        #expect(result.userInfo[GenerativeModelError.errorTypeKey] as? String == "unknown")
        let underlying = result.userInfo[NSUnderlyingErrorKey] as? NSError
        #expect(underlying?.domain == "unrelated")
        #expect(underlying?.code == 42)
        #expect(result.localizedDescription == "boom")
    }

    @Test func nsErrorExtractsHTTPStatusFromBackendErrorDomain() {
        let src = NSError(
            domain: "com.google.firebase.firebaseai.BackendError",
            code: 503,
            userInfo: [NSLocalizedDescriptionKey: "Service Unavailable"]
        )
        let result = GenerativeModelError.nsError(from: src)
        #expect(result.userInfo[GenerativeModelError.httpStatusCodeKey] as? Int == 503)
    }

    @Test func nsErrorReflectsFieldsFromCustomErrorValue() {
        struct FakeBackendError: Error {
            let httpResponseCode = 429
            let message = "quota exceeded"
            let status = "RESOURCE_EXHAUSTED"
        }
        let result = GenerativeModelError.nsError(from: FakeBackendError())
        #expect(result.userInfo[GenerativeModelError.httpStatusCodeKey] as? Int == 429)
        #expect(result.userInfo[GenerativeModelError.httpResponseBodyKey] as? String == "quota exceeded")
        #expect(result.userInfo[GenerativeModelError.rpcStatusKey] as? String == "RESOURCE_EXHAUSTED")
    }

    @Test func nsErrorReflectsResponseBodyFromUnrecognizedRPCError() {
        struct FakeUnrecognizedRPCError: Error {
            let responseBody = "{\"error\":\"oops\"}"
        }
        let result = GenerativeModelError.nsError(from: FakeUnrecognizedRPCError())
        #expect(result.userInfo[GenerativeModelError.httpResponseBodyKey] as? String == "{\"error\":\"oops\"}")
    }

    @Test func nsErrorFromOwnDomainIsIdempotent() {
        let src = NSError(
            domain: GenerativeModelError.domain,
            code: GenerativeModelErrorCode.internalError.rawValue,
            userInfo: [GenerativeModelError.errorTypeKey: "internalError"]
        )
        let result = GenerativeModelError.nsError(from: src)
        #expect(result === src)
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
