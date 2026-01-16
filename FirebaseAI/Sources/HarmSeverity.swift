import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHarmSeverity)
public final class HarmSeverity: NSObject {
    let value: FirebaseAILogic.SafetyRating.HarmSeverity

    init(value: FirebaseAILogic.SafetyRating.HarmSeverity) {
        self.value = value
        super.init()
    }

    @objc public var rawValue: String { value.rawValue }

    @objc public static var negligible: HarmSeverity {
        HarmSeverity(value: .negligible)
    }

    @objc public static var low: HarmSeverity {
        HarmSeverity(value: .low)
    }

    @objc public static var medium: HarmSeverity {
        HarmSeverity(value: .medium)
    }

    @objc public static var high: HarmSeverity {
        HarmSeverity(value: .high)
    }
}
