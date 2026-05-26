import FirebaseAILogic
import Foundation

/// Configures the sliding window context compression mechanism.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBSlidingWindow)
public final class SlidingWindow: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.SlidingWindow

    init(value: FirebaseAILogic.SlidingWindow) {
        self.value = value
        super.init()
    }

    /// Creates a sliding window configuration.
    /// - Parameter targetTokens: The target number of tokens to keep in the context window,
    ///   or `nil` for defaults.
    @objc public init(targetTokens: NSNumber?) {
        self.value = FirebaseAILogic.SlidingWindow(
            targetTokens: targetTokens?.intValue
        )
        super.init()
    }
}

/// Enables context window compression to manage the model's context window.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBContextWindowCompressionConfig)
public final class ContextWindowCompressionConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ContextWindowCompressionConfig

    init(value: FirebaseAILogic.ContextWindowCompressionConfig) {
        self.value = value
        super.init()
    }

    /// Creates a context window compression configuration.
    /// - Parameters:
    ///   - triggerTokens: The number of tokens that triggers compression, or `nil` for defaults.
    ///   - slidingWindow: The sliding window configuration, or `nil` to omit.
    @objc public init(triggerTokens: NSNumber?, slidingWindow: SlidingWindow?) {
        self.value = FirebaseAILogic.ContextWindowCompressionConfig(
            triggerTokens: triggerTokens?.intValue,
            slidingWindow: slidingWindow?.value
        )
        super.init()
    }
}
