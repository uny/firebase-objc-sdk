import FirebaseAILogic
import Foundation

/// Configuration for the session resumption mechanism.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBSessionResumptionConfig)
public final class SessionResumptionConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.SessionResumptionConfig

    init(value: FirebaseAILogic.SessionResumptionConfig) {
        self.value = value
        super.init()
    }

    /// Creates a new session resumption configuration.
    @objc public override init() {
        self.value = FirebaseAILogic.SessionResumptionConfig()
        super.init()
    }

    /// Resumes a previous session with the given handle.
    /// - Parameter handle: The session resumption handle from the previous session.
    @objc public init(handle: String) {
        self.value = FirebaseAILogic.SessionResumptionConfig(handle: handle)
        super.init()
    }
}
