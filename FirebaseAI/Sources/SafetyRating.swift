import FirebaseAILogic
import Foundation

/// A safety rating for generated content.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSafetyRating)
public final class SafetyRating: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.SafetyRating

    init(value: FirebaseAILogic.SafetyRating) {
        self.value = value
        super.init()
    }

    /// The harm category of this rating.
    @objc public var category: HarmCategory {
        HarmCategory(value: value.category)
    }

    /// The probability of harmful content.
    @objc public var probability: HarmProbability {
        HarmProbability(value: value.probability)
    }

    /// The probability score as a floating-point value.
    @objc public var probabilityScore: Float {
        value.probabilityScore
    }

    /// The severity of harmful content.
    @objc public var severity: HarmSeverity {
        HarmSeverity(value: value.severity)
    }

    /// The severity score as a floating-point value.
    @objc public var severityScore: Float {
        value.severityScore
    }

    /// Whether the content was blocked due to this safety rating.
    @objc public var blocked: Bool {
        value.blocked
    }
}
