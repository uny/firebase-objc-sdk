import FirebaseAILogic
import Foundation

/// Reasons why a prompt was blocked.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBBlockReason)
public final class BlockReason: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.PromptFeedback.BlockReason

    init(value: FirebaseAILogic.PromptFeedback.BlockReason) {
        self.value = value
        super.init()
    }

    /// The raw string value of the block reason.
    @objc public var rawValue: String { value.rawValue }

    /// The prompt was blocked due to safety concerns.
    @objc public static var safety: BlockReason {
        BlockReason(value: .safety)
    }

    /// The prompt was blocked for another unspecified reason.
    @objc public static var other: BlockReason {
        BlockReason(value: .other)
    }

    /// The prompt was blocked because it matched a blocklist.
    @objc public static var blocklist: BlockReason {
        BlockReason(value: .blocklist)
    }

    /// The prompt was blocked due to prohibited content.
    @objc public static var prohibitedContent: BlockReason {
        BlockReason(value: .prohibitedContent)
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? BlockReason else { return false }
        return value.rawValue == other.value.rawValue
    }

    public override var hash: Int {
        value.rawValue.hashValue
    }
}
