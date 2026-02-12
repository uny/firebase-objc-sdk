import FirebaseAILogic
import Foundation

/// Probability levels of harmful content.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHarmProbability)
public final class HarmProbability: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.SafetyRating.HarmProbability

    init(value: FirebaseAILogic.SafetyRating.HarmProbability) {
        self.value = value
        super.init()
    }

    /// The raw string value of the harm probability.
    @objc public var rawValue: String { value.rawValue }

    /// Negligible probability of harmful content.
    @objc public static var negligible: HarmProbability {
        HarmProbability(value: .negligible)
    }

    /// Low probability of harmful content.
    @objc public static var low: HarmProbability {
        HarmProbability(value: .low)
    }

    /// Medium probability of harmful content.
    @objc public static var medium: HarmProbability {
        HarmProbability(value: .medium)
    }

    /// High probability of harmful content.
    @objc public static var high: HarmProbability {
        HarmProbability(value: .high)
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? HarmProbability else { return false }
        return value.rawValue == other.value.rawValue
    }

    public override var hash: Int {
        value.rawValue.hashValue
    }
}
