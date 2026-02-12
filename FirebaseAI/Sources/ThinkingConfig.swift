import FirebaseAILogic
import Foundation

// MARK: - ThinkingLevel

/// Thinking budget levels for the model.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBThinkingLevel)
public final class ThinkingLevel: NSObject, @unchecked Sendable {
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

/// Configuration for the model's thinking process.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBThinkingConfig)
public final class ThinkingConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ThinkingConfig

    init(value: FirebaseAILogic.ThinkingConfig) {
        self.value = value
        super.init()
    }

    /// Creates a thinking configuration with an explicit token budget.
    /// - Parameters:
    ///   - thinkingBudget: The maximum number of thinking tokens, or `nil` for the default.
    ///   - includeThoughts: Whether to include thought parts in the response, or `nil` for the default.
    @objc public convenience init(thinkingBudget: NSNumber?, includeThoughts: NSNumber?) {
        let config = FirebaseAILogic.ThinkingConfig(
            thinkingBudget: thinkingBudget?.intValue,
            includeThoughts: includeThoughts?.boolValue
        )
        self.init(value: config)
    }

    /// Creates a thinking configuration with a predefined thinking level.
    /// - Parameters:
    ///   - thinkingLevel: The thinking budget level.
    ///   - includeThoughts: Whether to include thought parts in the response, or `nil` for the default.
    @objc public convenience init(thinkingLevel: ThinkingLevel, includeThoughts: NSNumber?) {
        let config = FirebaseAILogic.ThinkingConfig(
            thinkingLevel: thinkingLevel.value,
            includeThoughts: includeThoughts?.boolValue
        )
        self.init(value: config)
    }
}
