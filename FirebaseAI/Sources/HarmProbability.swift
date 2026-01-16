import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHarmProbability)
public final class HarmProbability: NSObject {
    let value: FirebaseAILogic.SafetyRating.HarmProbability

    init(value: FirebaseAILogic.SafetyRating.HarmProbability) {
        self.value = value
        super.init()
    }

    @objc public var rawValue: String { value.rawValue }

    @objc public static var negligible: HarmProbability {
        HarmProbability(value: .negligible)
    }

    @objc public static var low: HarmProbability {
        HarmProbability(value: .low)
    }

    @objc public static var medium: HarmProbability {
        HarmProbability(value: .medium)
    }

    @objc public static var high: HarmProbability {
        HarmProbability(value: .high)
    }
}
