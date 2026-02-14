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

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ThinkingLevel else { return false }
        return value == other.value
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}

// MARK: - ThinkingConfig

/// Configuration for the model's thinking process.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBThinkingConfig)
public final class ThinkingConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ThinkingConfig

    // Stored copies of init parameters (upstream properties are internal).
    private let _thinkingBudget: NSNumber?
    private let _thinkingLevel: ThinkingLevel?
    private let _includeThoughts: NSNumber?

    init(value: FirebaseAILogic.ThinkingConfig) {
        self.value = value
        _thinkingBudget = nil
        _thinkingLevel = nil
        _includeThoughts = nil
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
        self.init(value: config,
                  thinkingBudget: thinkingBudget,
                  thinkingLevel: nil,
                  includeThoughts: includeThoughts)
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
        self.init(value: config,
                  thinkingBudget: nil,
                  thinkingLevel: thinkingLevel,
                  includeThoughts: includeThoughts)
    }

    private init(
        value: FirebaseAILogic.ThinkingConfig,
        thinkingBudget: NSNumber?,
        thinkingLevel: ThinkingLevel?,
        includeThoughts: NSNumber?
    ) {
        self.value = value
        _thinkingBudget = thinkingBudget
        _thinkingLevel = thinkingLevel
        _includeThoughts = includeThoughts
        super.init()
    }

    // MARK: - Read Properties

    /// The maximum number of thinking tokens, or `nil` if not set.
    @objc public var thinkingBudget: NSNumber? { _thinkingBudget }

    /// The thinking budget level, or `nil` if not set.
    @objc public var thinkingLevel: ThinkingLevel? { _thinkingLevel }

    /// Whether to include thought parts in the response, or `nil` if not set.
    @objc public var includeThoughts: NSNumber? { _includeThoughts }
}
