import FirebaseAILogic
import Foundation

/// Configuration for tool usage.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBToolConfig)
public final class ToolConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ToolConfig

    init(value: FirebaseAILogic.ToolConfig) {
        self.value = value
        super.init()
    }

    /// Creates a tool configuration.
    /// - Parameter functionCallingConfig: The function calling configuration, or `nil` for defaults.
    @objc public init(functionCallingConfig: FunctionCallingConfig?) {
        self.value = FirebaseAILogic.ToolConfig(
            functionCallingConfig: functionCallingConfig?.value
        )
        super.init()
    }
}
