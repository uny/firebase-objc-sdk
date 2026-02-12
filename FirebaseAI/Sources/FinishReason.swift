import FirebaseAILogic
import Foundation

/// Reasons why model generation finished.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFinishReason)
public final class FinishReason: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.FinishReason

    init(value: FirebaseAILogic.FinishReason) {
        self.value = value
        super.init()
    }

    /// The raw string value of the finish reason.
    @objc public var rawValue: String { value.rawValue }

    /// Generation stopped naturally or hit a configured stop sequence.
    @objc public static var stop: FinishReason {
        FinishReason(value: .stop)
    }

    /// Generation stopped because the maximum token limit was reached.
    @objc public static var maxTokens: FinishReason {
        FinishReason(value: .maxTokens)
    }

    /// Generation stopped due to safety concerns.
    @objc public static var safety: FinishReason {
        FinishReason(value: .safety)
    }

    /// Generation stopped due to recitation detection.
    @objc public static var recitation: FinishReason {
        FinishReason(value: .recitation)
    }

    /// Generation stopped for another unspecified reason.
    @objc public static var other: FinishReason {
        FinishReason(value: .other)
    }

    /// Generation stopped because content matched a blocklist.
    @objc public static var blocklist: FinishReason {
        FinishReason(value: .blocklist)
    }

    /// Generation stopped due to prohibited content.
    @objc public static var prohibitedContent: FinishReason {
        FinishReason(value: .prohibitedContent)
    }

    /// Generation stopped due to sensitive personally identifiable information (SPII).
    @objc public static var spii: FinishReason {
        FinishReason(value: .spii)
    }

    /// Generation stopped due to a malformed function call.
    @objc public static var malformedFunctionCall: FinishReason {
        FinishReason(value: .malformedFunctionCall)
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? FinishReason else { return false }
        return value.rawValue == other.value.rawValue
    }

    public override var hash: Int {
        value.rawValue.hashValue
    }
}
