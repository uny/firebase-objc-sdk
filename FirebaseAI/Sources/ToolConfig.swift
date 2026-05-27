import FirebaseAILogic
import Foundation

/// Configuration for tool usage.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBToolConfig)
public final class ToolConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ToolConfig

    init(value: FirebaseAILogic.ToolConfig) {
        self.value = value
        super.init()
    }

    /// Creates a tool configuration.
    /// - Parameter functionCallingConfig: The function calling configuration, or `nil` for defaults.
    @objc public convenience init(functionCallingConfig: FunctionCallingConfig?) {
        self.init(functionCallingConfig: functionCallingConfig, retrievalConfig: nil)
    }

    /// Creates a tool configuration.
    /// - Parameters:
    ///   - functionCallingConfig: The function calling configuration, or `nil` for defaults.
    ///   - retrievalConfig: The retrieval configuration, or `nil` to omit.
    @objc public init(functionCallingConfig: FunctionCallingConfig?,
                      retrievalConfig: RetrievalConfig?) {
        self.value = FirebaseAILogic.ToolConfig(
            functionCallingConfig: functionCallingConfig?.value,
            retrievalConfig: retrievalConfig?.value
        )
        super.init()
    }
}
