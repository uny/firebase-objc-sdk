import FirebaseAILogic
import Foundation

/// Severity levels of harmful content.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHarmSeverity)
public final class HarmSeverity: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.SafetyRating.HarmSeverity

    init(value: FirebaseAILogic.SafetyRating.HarmSeverity) {
        self.value = value
        super.init()
    }

    /// The raw string value of the harm severity.
    @objc public var rawValue: String { value.rawValue }

    /// Negligible severity of harmful content.
    @objc public static var negligible: HarmSeverity {
        HarmSeverity(value: .negligible)
    }

    /// Low severity of harmful content.
    @objc public static var low: HarmSeverity {
        HarmSeverity(value: .low)
    }

    /// Medium severity of harmful content.
    @objc public static var medium: HarmSeverity {
        HarmSeverity(value: .medium)
    }

    /// High severity of harmful content.
    @objc public static var high: HarmSeverity {
        HarmSeverity(value: .high)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? HarmSeverity else { return false }
        return value.rawValue == other.value.rawValue
    }

    override public var hash: Int {
        value.rawValue.hashValue
    }
}
