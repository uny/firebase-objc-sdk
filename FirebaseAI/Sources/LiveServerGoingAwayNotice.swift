import FirebaseAILogic
import Foundation

/// A notice that the live session server is going away.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerGoingAwayNotice)
public final class LiveServerGoingAwayNotice: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.LiveServerGoingAwayNotice

    init(value: FirebaseAILogic.LiveServerGoingAwayNotice) {
        self.value = value
        super.init()
    }

    /// The time remaining before the server disconnects, in seconds.
    @objc public var timeLeft: NSNumber? {
        return value.timeLeft.map { NSNumber(value: $0) }
    }
}
