import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHarmBlockThreshold)
public final class HarmBlockThreshold: NSObject {
    let value: FirebaseAILogic.SafetySetting.HarmBlockThreshold

    init(value: FirebaseAILogic.SafetySetting.HarmBlockThreshold) {
        self.value = value
        super.init()
    }

    @objc public static var blockLowAndAbove: HarmBlockThreshold {
        HarmBlockThreshold(value: .blockLowAndAbove)
    }

    @objc public static var blockMediumAndAbove: HarmBlockThreshold {
        HarmBlockThreshold(value: .blockMediumAndAbove)
    }

    @objc public static var blockOnlyHigh: HarmBlockThreshold {
        HarmBlockThreshold(value: .blockOnlyHigh)
    }

    @objc public static var blockNone: HarmBlockThreshold {
        HarmBlockThreshold(value: .blockNone)
    }

    @objc public static var off: HarmBlockThreshold {
        HarmBlockThreshold(value: .off)
    }
}
