import FirebaseAILogic
import Foundation

// MARK: - LiveSessionUnsupportedMessageError

/// An error thrown when an unsupported message type is received in a live session.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveSessionUnsupportedMessageError)
public final class LiveSessionUnsupportedMessageError: NSObject, @unchecked Sendable {
    /// The underlying error.
    @objc public let underlyingError: NSError

    private init(underlyingError: NSError) {
        self.underlyingError = underlyingError
        super.init()
    }

    /// Extracts a `LiveSessionUnsupportedMessageError` from an `NSError` if applicable.
    ///
    /// - Parameter error: The `NSError` to extract from.
    /// - Returns: A `LiveSessionUnsupportedMessageError` if the error matches, or `nil`.
    @objc public static func from(_ error: NSError) -> LiveSessionUnsupportedMessageError? {
        guard error is FirebaseAILogic.LiveSessionUnsupportedMessageError else {
            return nil
        }
        if let underlying = error.userInfo[NSUnderlyingErrorKey] as? NSError {
            return LiveSessionUnsupportedMessageError(underlyingError: underlying)
        }
        return LiveSessionUnsupportedMessageError(underlyingError: error)
    }
}

// MARK: - LiveSessionLostConnectionError

/// An error thrown when a live session loses its connection.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveSessionLostConnectionError)
public final class LiveSessionLostConnectionError: NSObject, @unchecked Sendable {
    /// The underlying error.
    @objc public let underlyingError: NSError

    private init(underlyingError: NSError) {
        self.underlyingError = underlyingError
        super.init()
    }

    /// Extracts a `LiveSessionLostConnectionError` from an `NSError` if applicable.
    ///
    /// - Parameter error: The `NSError` to extract from.
    /// - Returns: A `LiveSessionLostConnectionError` if the error matches, or `nil`.
    @objc public static func from(_ error: NSError) -> LiveSessionLostConnectionError? {
        guard error is FirebaseAILogic.LiveSessionLostConnectionError else {
            return nil
        }
        if let underlying = error.userInfo[NSUnderlyingErrorKey] as? NSError {
            return LiveSessionLostConnectionError(underlyingError: underlying)
        }
        return LiveSessionLostConnectionError(underlyingError: error)
    }
}

// MARK: - LiveSessionUnexpectedClosureError

/// An error thrown when a live session is unexpectedly closed.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveSessionUnexpectedClosureError)
public final class LiveSessionUnexpectedClosureError: NSObject, @unchecked Sendable {
    /// The underlying error.
    @objc public let underlyingError: NSError

    private init(underlyingError: NSError) {
        self.underlyingError = underlyingError
        super.init()
    }

    /// Extracts a `LiveSessionUnexpectedClosureError` from an `NSError` if applicable.
    ///
    /// - Parameter error: The `NSError` to extract from.
    /// - Returns: A `LiveSessionUnexpectedClosureError` if the error matches, or `nil`.
    @objc public static func from(_ error: NSError) -> LiveSessionUnexpectedClosureError? {
        guard error is FirebaseAILogic.LiveSessionUnexpectedClosureError else {
            return nil
        }
        if let underlying = error.userInfo[NSUnderlyingErrorKey] as? NSError {
            return LiveSessionUnexpectedClosureError(underlyingError: underlying)
        }
        return LiveSessionUnexpectedClosureError(underlyingError: error)
    }
}

// MARK: - LiveSessionSetupError

/// An error thrown during live session setup.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveSessionSetupError)
public final class LiveSessionSetupError: NSObject, @unchecked Sendable {
    /// The underlying error.
    @objc public let underlyingError: NSError

    private init(underlyingError: NSError) {
        self.underlyingError = underlyingError
        super.init()
    }

    /// Extracts a `LiveSessionSetupError` from an `NSError` if applicable.
    ///
    /// - Parameter error: The `NSError` to extract from.
    /// - Returns: A `LiveSessionSetupError` if the error matches, or `nil`.
    @objc public static func from(_ error: NSError) -> LiveSessionSetupError? {
        guard error is FirebaseAILogic.LiveSessionSetupError else {
            return nil
        }
        if let underlying = error.userInfo[NSUnderlyingErrorKey] as? NSError {
            return LiveSessionSetupError(underlyingError: underlying)
        }
        return LiveSessionSetupError(underlyingError: error)
    }
}
