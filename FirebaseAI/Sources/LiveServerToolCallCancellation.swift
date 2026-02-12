import FirebaseAILogic
import Foundation

/// A cancellation of a tool call during a live session.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerToolCallCancellation)
public final class LiveServerToolCallCancellation: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.LiveServerToolCallCancellation

    init(value: FirebaseAILogic.LiveServerToolCallCancellation) {
        self.value = value
        super.init()
    }

    /// The IDs of the cancelled tool calls.
    @objc public var ids: [String]? {
        return value.ids
    }
}
