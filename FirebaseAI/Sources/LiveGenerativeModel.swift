import FirebaseAILogic
import Foundation

/// A model for live bidirectional streaming sessions.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveGenerativeModel)
public final class LiveGenerativeModel: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.LiveGenerativeModel

    init(value: FirebaseAILogic.LiveGenerativeModel) {
        self.value = value
        super.init()
    }

    /// Connects to the server and returns an active live session.
    @objc public func connect() async throws -> LiveSession {
        let session = try await value.connect()
        return LiveSession(value: session)
    }
}
