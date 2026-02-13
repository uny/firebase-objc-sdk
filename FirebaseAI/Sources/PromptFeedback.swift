import FirebaseAILogic
import Foundation

/// Feedback about whether a prompt was blocked.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBPromptFeedback)
public final class PromptFeedback: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.PromptFeedback

    init(value: FirebaseAILogic.PromptFeedback) {
        self.value = value
        super.init()
    }

    /// The reason the prompt was blocked, if applicable.
    @objc public var blockReason: BlockReason? {
        value.blockReason.map { BlockReason(value: $0) }
    }

    /// A human-readable message describing the block reason.
    @objc public var blockReasonMessage: String? {
        value.blockReasonMessage
    }

    /// The safety ratings for the prompt.
    @objc public var safetyRatings: [SafetyRating] {
        value.safetyRatings.map { SafetyRating(value: $0) }
    }
}
