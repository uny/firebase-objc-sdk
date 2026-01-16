import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBPromptFeedback)
public final class PromptFeedback: NSObject {
    let value: FirebaseAILogic.PromptFeedback

    init(value: FirebaseAILogic.PromptFeedback) {
        self.value = value
        super.init()
    }

    @objc public var blockReason: BlockReason? {
        value.blockReason.map { BlockReason(value: $0) }
    }

    @objc public var blockReasonMessage: String? {
        value.blockReasonMessage
    }

    @objc public var safetyRatings: [SafetyRating] {
        value.safetyRatings.map { SafetyRating(value: $0) }
    }
}
