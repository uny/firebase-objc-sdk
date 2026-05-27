import FirebaseAILogic
import Foundation

/// An update of the session resumption state.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveSessionResumptionUpdate)
public final class LiveSessionResumptionUpdate: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.LiveSessionResumptionUpdate

    init(value: FirebaseAILogic.LiveSessionResumptionUpdate) {
        self.value = value
        super.init()
    }

    /// The new handle that represents the state that can be resumed.
    @objc public var newHandle: String? { value.newHandle }

    /// Indicates if the session can be resumed at this point.
    @objc public var resumable: Bool { value.resumable }

    /// The index of the last client message included in this state update.
    @objc public var lastConsumedClientMessageIndex: NSNumber? {
        value.lastConsumedClientMessageIndex.map { NSNumber(value: $0) }
    }
}
