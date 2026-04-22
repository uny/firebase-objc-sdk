import FirebaseAILogic
import Foundation

/// Error codes for `GenerativeModelError.domain`.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerativeModelErrorCode)
public enum GenerativeModelErrorCode: Int {
    case internalError = 0
    case promptImageContentError = 1
    case promptBlocked = 2
    case responseStoppedEarly = 3
    case unknown = 99

    var label: String {
        switch self {
        case .internalError: return "internalError"
        case .promptImageContentError: return "promptImageContentError"
        case .promptBlocked: return "promptBlocked"
        case .responseStoppedEarly: return "responseStoppedEarly"
        case .unknown: return "unknown"
        }
    }
}

/// Converts errors thrown from `FirebaseAILogic` into `NSError`s with a stable
/// domain / code and rich `userInfo`, so that associated values (HTTP status,
/// response body, underlying error metadata) survive the `@objc` / Kotlin / MPP
/// boundary — where Swift enum associated values would otherwise be lost.
///
/// The underlying error is preserved via Foundation's standard `NSUnderlyingErrorKey`
/// so consumers can walk the chain with `userInfo[NSUnderlyingErrorKey]` as usual.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerativeModelError)
public final class GenerativeModelError: NSObject {
    @objc public static let domain = "dev.ynagai.firebase.ai.GenerativeModelError"

    @objc public static let errorTypeKey = "KFBErrorType"
    @objc public static let httpStatusCodeKey = "KFBHTTPStatusCode"
    @objc public static let httpResponseBodyKey = "KFBHTTPResponseBody"
    @objc public static let finishReasonKey = "KFBFinishReason"

    static func nsError(from error: Error) -> NSError {
        if let gcError = error as? FirebaseAILogic.GenerateContentError {
            return nsError(from: gcError)
        }
        let ns = error as NSError
        if ns.domain == domain {
            return ns
        }
        let code = GenerativeModelErrorCode.unknown
        let userInfo: [String: Any] = [
            errorTypeKey: code.label,
            NSUnderlyingErrorKey: ns,
            NSLocalizedDescriptionKey: ns.localizedDescription,
        ]
        return NSError(domain: domain, code: code.rawValue, userInfo: userInfo)
    }

    private static func nsError(from error: FirebaseAILogic.GenerateContentError) -> NSError {
        var userInfo: [String: Any] = [:]
        let code: GenerativeModelErrorCode
        switch error {
        case .internalError(let underlying):
            code = .internalError
            enrich(&userInfo, withUnderlying: underlying)
        case .promptImageContentError(let underlying):
            code = .promptImageContentError
            enrich(&userInfo, withUnderlying: underlying)
        case .promptBlocked(let resp):
            code = .promptBlocked
            userInfo[NSLocalizedDescriptionKey] =
                "Prompt blocked: \(String(describing: resp.promptFeedback))"
        case .responseStoppedEarly(let reason, _):
            code = .responseStoppedEarly
            userInfo[finishReasonKey] = String(describing: reason)
            userInfo[NSLocalizedDescriptionKey] = "Response stopped early: \(reason)"
        }
        userInfo[errorTypeKey] = code.label
        if userInfo[NSLocalizedDescriptionKey] == nil {
            userInfo[NSLocalizedDescriptionKey] = String(describing: error)
        }
        return NSError(domain: domain, code: code.rawValue, userInfo: userInfo)
    }

    private static func enrich(_ userInfo: inout [String: Any], withUnderlying error: Error) {
        let ns = error as NSError
        userInfo[NSUnderlyingErrorKey] = ns
        userInfo[NSLocalizedDescriptionKey] = ns.localizedDescription

        // Key names used by FirebaseAILogic for HTTP details are version-dependent;
        // probe known candidates. When the real key is confirmed from a prod dump,
        // move it to the front of the list.
        let httpStatusCandidates = ["HTTPStatusCode", "statusCode", "com.google.HTTPStatus"]
        userInfo[httpStatusCodeKey] = httpStatusCandidates
            .compactMap { ns.userInfo[$0] as? Int }
            .first

        let bodyCandidates = ["HTTPResponseBody", "responseBody", "com.google.HTTPResponseBody"]
        userInfo[httpResponseBodyKey] = bodyCandidates
            .compactMap { key -> String? in
                if let s = ns.userInfo[key] as? String { return s }
                if let d = ns.userInfo[key] as? Data { return String(data: d, encoding: .utf8) }
                return nil
            }
            .first
    }
}

/// Wraps an async throwing operation and rewrites any error as a `GenerativeModelError` NSError.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@inline(__always)
func mapFirebaseAIErrors<T>(_ body: () async throws -> T) async throws -> T {
    do {
        return try await body()
    } catch {
        throw GenerativeModelError.nsError(from: error)
    }
}

/// Wraps a synchronous throwing operation and rewrites any error as a `GenerativeModelError` NSError.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@inline(__always)
func mapFirebaseAIErrors<T>(_ body: () throws -> T) throws -> T {
    do {
        return try body()
    } catch {
        throw GenerativeModelError.nsError(from: error)
    }
}
