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
    case unknown = 4

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
    @objc public static let rpcStatusKey = "KFBRPCStatus"
    @objc public static let finishReasonKey = "KFBFinishReason"
    @objc public static let blockReasonKey = "KFBBlockReason"
    @objc public static let usagePromptTokensKey = "KFBUsagePromptTokens"
    @objc public static let usageCandidatesTokensKey = "KFBUsageCandidatesTokens"
    @objc public static let usageTotalTokensKey = "KFBUsageTotalTokens"

    private static let backendErrorDomain = "com.google.firebase.firebaseai.BackendError"

    override private init() { super.init() }

    static func nsError(from error: Error) -> NSError {
        if let gcError = error as? FirebaseAILogic.GenerateContentError {
            return nsError(from: gcError)
        }
        let ns = error as NSError
        if ns.domain == domain {
            return ns
        }
        var userInfo: [String: Any] = [:]
        enrich(&userInfo, withUnderlying: error)
        userInfo[errorTypeKey] = GenerativeModelErrorCode.unknown.label
        return NSError(domain: domain, code: GenerativeModelErrorCode.unknown.rawValue, userInfo: userInfo)
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
            if let reason = resp.promptFeedback?.blockReason {
                userInfo[blockReasonKey] = String(describing: reason)
                userInfo[NSLocalizedDescriptionKey] = "Prompt blocked: \(reason)"
            } else if let message = resp.promptFeedback?.blockReasonMessage {
                userInfo[NSLocalizedDescriptionKey] = "Prompt blocked: \(message)"
            } else {
                userInfo[NSLocalizedDescriptionKey] = "Prompt blocked."
            }
            enrichWithUsage(&userInfo, response: resp)
        case .responseStoppedEarly(let reason, let resp):
            code = .responseStoppedEarly
            userInfo[finishReasonKey] = String(describing: reason)
            userInfo[NSLocalizedDescriptionKey] = "Response stopped early: \(reason)"
            enrichWithUsage(&userInfo, response: resp)
        }
        userInfo[errorTypeKey] = code.label
        return NSError(domain: domain, code: code.rawValue, userInfo: userInfo)
    }

    /// Extracts HTTP status, response body, RPC status and domain/code metadata from
    /// `FirebaseAILogic`'s internal error types. `BackendError` conforms to
    /// `CustomNSError` and encodes the HTTP status as `NSError.code`; `message`,
    /// `status`, `details`, and `UnrecognizedRPCError.responseBody` are only
    /// reachable via reflection because the underlying types are not public.
    private static func enrich(_ userInfo: inout [String: Any], withUnderlying error: Error) {
        let ns = error as NSError
        userInfo[NSUnderlyingErrorKey] = ns
        if userInfo[NSLocalizedDescriptionKey] == nil {
            userInfo[NSLocalizedDescriptionKey] = ns.localizedDescription
        }

        if ns.domain == backendErrorDomain {
            userInfo[httpStatusCodeKey] = ns.code
        }

        for (label, value) in Mirror(reflecting: error).children {
            guard let label else { continue }
            switch label {
            case "httpResponseCode":
                if let i = value as? Int { userInfo[httpStatusCodeKey] = i }
            case "message":
                if let s = value as? String, !s.isEmpty {
                    userInfo[httpResponseBodyKey] = s
                }
            case "responseBody":
                if let s = value as? String {
                    userInfo[httpResponseBodyKey] = s
                } else if let d = value as? Data, let s = String(data: d, encoding: .utf8) {
                    userInfo[httpResponseBodyKey] = s
                }
            case "status":
                userInfo[rpcStatusKey] = String(describing: value)
            default:
                break
            }
        }
    }

    private static func enrichWithUsage(
        _ userInfo: inout [String: Any],
        response: FirebaseAILogic.GenerateContentResponse
    ) {
        guard let usage = response.usageMetadata else { return }
        userInfo[usagePromptTokensKey] = usage.promptTokenCount
        userInfo[usageCandidatesTokensKey] = usage.candidatesTokenCount
        userInfo[usageTotalTokensKey] = usage.totalTokenCount
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
