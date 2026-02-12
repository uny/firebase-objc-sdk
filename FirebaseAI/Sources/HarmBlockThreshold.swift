import FirebaseAILogic
import Foundation

/// Threshold levels for blocking harmful content.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHarmBlockThreshold)
public final class HarmBlockThreshold: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.SafetySetting.HarmBlockThreshold

    init(value: FirebaseAILogic.SafetySetting.HarmBlockThreshold) {
        self.value = value
        super.init()
    }

    /// Block content with low harm probability and above.
    @objc public static var blockLowAndAbove: HarmBlockThreshold {
        HarmBlockThreshold(value: .blockLowAndAbove)
    }

    /// Block content with medium harm probability and above.
    @objc public static var blockMediumAndAbove: HarmBlockThreshold {
        HarmBlockThreshold(value: .blockMediumAndAbove)
    }

    /// Block only content with high harm probability.
    @objc public static var blockOnlyHigh: HarmBlockThreshold {
        HarmBlockThreshold(value: .blockOnlyHigh)
    }

    /// Do not block any content.
    @objc public static var blockNone: HarmBlockThreshold {
        HarmBlockThreshold(value: .blockNone)
    }

    /// Turn off the safety filter entirely.
    @objc public static var off: HarmBlockThreshold {
        HarmBlockThreshold(value: .off)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? HarmBlockThreshold else { return false }
        return String(describing: value) == String(describing: other.value)
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}
