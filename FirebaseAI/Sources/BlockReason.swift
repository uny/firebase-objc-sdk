import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBBlockReason)
public final class BlockReason: NSObject {
    let value: FirebaseAILogic.PromptFeedback.BlockReason

    init(value: FirebaseAILogic.PromptFeedback.BlockReason) {
        self.value = value
        super.init()
    }

    @objc public var rawValue: String { value.rawValue }

    @objc public static var safety: BlockReason {
        BlockReason(value: .safety)
    }

    @objc public static var other: BlockReason {
        BlockReason(value: .other)
    }

    @objc public static var blocklist: BlockReason {
        BlockReason(value: .blocklist)
    }

    @objc public static var prohibitedContent: BlockReason {
        BlockReason(value: .prohibitedContent)
    }
}
