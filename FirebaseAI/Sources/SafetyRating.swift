import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSafetyRating)
public final class SafetyRating: NSObject {
    let value: FirebaseAILogic.SafetyRating

    init(value: FirebaseAILogic.SafetyRating) {
        self.value = value
        super.init()
    }

    @objc public var category: HarmCategory {
        HarmCategory(value: value.category)
    }

    @objc public var probability: HarmProbability {
        HarmProbability(value: value.probability)
    }

    @objc public var probabilityScore: Float {
        value.probabilityScore
    }

    @objc public var severity: HarmSeverity {
        HarmSeverity(value: value.severity)
    }

    @objc public var severityScore: Float {
        value.severityScore
    }

    @objc public var blocked: Bool {
        value.blocked
    }
}
