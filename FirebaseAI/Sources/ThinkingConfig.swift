import FirebaseAILogic
import Foundation

// MARK: - ThinkingLevel

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBThinkingLevel)
public final class ThinkingLevel: NSObject {
    let value: FirebaseAILogic.ThinkingConfig.ThinkingLevel

    init(value: FirebaseAILogic.ThinkingConfig.ThinkingLevel) {
        self.value = value
        super.init()
    }

    @objc public static var minimal: ThinkingLevel {
        ThinkingLevel(value: .minimal)
    }

    @objc public static var low: ThinkingLevel {
        ThinkingLevel(value: .low)
    }

    @objc public static var medium: ThinkingLevel {
        ThinkingLevel(value: .medium)
    }

    @objc public static var high: ThinkingLevel {
        ThinkingLevel(value: .high)
    }
}

// MARK: - ThinkingConfig

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBThinkingConfig)
public final class ThinkingConfig: NSObject {
    let value: FirebaseAILogic.ThinkingConfig

    init(value: FirebaseAILogic.ThinkingConfig) {
        self.value = value
        super.init()
    }

    @objc public convenience init(thinkingBudget: NSNumber?, includeThoughts: NSNumber?) {
        let config = FirebaseAILogic.ThinkingConfig(
            thinkingBudget: thinkingBudget?.intValue,
            includeThoughts: includeThoughts?.boolValue
        )
        self.init(value: config)
    }

    @objc public convenience init(thinkingLevel: ThinkingLevel, includeThoughts: NSNumber?) {
        let config = FirebaseAILogic.ThinkingConfig(
            thinkingLevel: thinkingLevel.value,
            includeThoughts: includeThoughts?.boolValue
        )
        self.init(value: config)
    }
}
