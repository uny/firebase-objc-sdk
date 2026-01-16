import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFinishReason)
public final class FinishReason: NSObject {
    let value: FirebaseAILogic.FinishReason

    init(value: FirebaseAILogic.FinishReason) {
        self.value = value
        super.init()
    }

    @objc public var rawValue: String { value.rawValue }

    @objc public static var stop: FinishReason {
        FinishReason(value: .stop)
    }

    @objc public static var maxTokens: FinishReason {
        FinishReason(value: .maxTokens)
    }

    @objc public static var safety: FinishReason {
        FinishReason(value: .safety)
    }

    @objc public static var recitation: FinishReason {
        FinishReason(value: .recitation)
    }

    @objc public static var other: FinishReason {
        FinishReason(value: .other)
    }

    @objc public static var blocklist: FinishReason {
        FinishReason(value: .blocklist)
    }

    @objc public static var prohibitedContent: FinishReason {
        FinishReason(value: .prohibitedContent)
    }

    @objc public static var spii: FinishReason {
        FinishReason(value: .spii)
    }

    @objc public static var malformedFunctionCall: FinishReason {
        FinishReason(value: .malformedFunctionCall)
    }
}
