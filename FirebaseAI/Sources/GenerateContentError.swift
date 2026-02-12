import FirebaseAILogic
import Foundation

/// Types of content generation errors.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerateContentErrorType)
public enum GenerateContentErrorType: Int {
    case internalError
    case promptImageContentError
    case promptBlocked
    case responseStoppedEarly
}

/// An error from a content generation request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerateContentError)
public final class GenerateContentError: NSObject, @unchecked Sendable {
    /// The type of error that occurred.
    @objc public let errorType: GenerateContentErrorType
    /// The underlying error, if available.
    @objc public let underlyingError: NSError?
    /// The partial response, if available.
    @objc public let response: GenerateContentResponse?
    /// The reason generation was stopped, if applicable.
    @objc public let finishReason: FinishReason?

    private init(
        errorType: GenerateContentErrorType,
        underlyingError: NSError?,
        response: GenerateContentResponse?,
        finishReason: FinishReason?
    ) {
        self.errorType = errorType
        self.underlyingError = underlyingError
        self.response = response
        self.finishReason = finishReason
        super.init()
    }

    /// Extracts a `GenerateContentError` from an `NSError` if it wraps a
    /// `FirebaseAILogic.GenerateContentError`.
    @objc public static func from(_ error: NSError) -> GenerateContentError? {
        guard let underlying = error as? FirebaseAILogic.GenerateContentError else {
            return nil
        }
        return from(underlying)
    }

    static func from(_ error: FirebaseAILogic.GenerateContentError) -> GenerateContentError {
        switch error {
        case .internalError(let underlying):
            return GenerateContentError(
                errorType: .internalError,
                underlyingError: underlying as NSError,
                response: nil,
                finishReason: nil
            )
        case .promptImageContentError(let underlying):
            return GenerateContentError(
                errorType: .promptImageContentError,
                underlyingError: underlying as NSError,
                response: nil,
                finishReason: nil
            )
        case .promptBlocked(let resp):
            return GenerateContentError(
                errorType: .promptBlocked,
                underlyingError: nil,
                response: GenerateContentResponse(value: resp),
                finishReason: nil
            )
        case .responseStoppedEarly(let reason, let resp):
            return GenerateContentError(
                errorType: .responseStoppedEarly,
                underlyingError: nil,
                response: GenerateContentResponse(value: resp),
                finishReason: FinishReason(value: reason)
            )
        }
    }
}
