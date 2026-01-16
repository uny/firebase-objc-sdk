import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerGoingAwayNotice)
public final class LiveServerGoingAwayNotice: NSObject {
    let value: FirebaseAILogic.LiveServerGoingAwayNotice

    init(value: FirebaseAILogic.LiveServerGoingAwayNotice) {
        self.value = value
        super.init()
    }

    @objc public var timeLeft: NSNumber? {
        return value.timeLeft.map { NSNumber(value: $0) }
    }
}
