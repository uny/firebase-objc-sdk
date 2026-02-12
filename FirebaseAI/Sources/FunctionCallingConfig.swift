import FirebaseAILogic
import Foundation

/// Configuration for function calling behavior.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFunctionCallingConfig)
public final class FunctionCallingConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.FunctionCallingConfig

    init(value: FirebaseAILogic.FunctionCallingConfig) {
        self.value = value
        super.init()
    }

    /// The model decides whether to call a function.
    @objc public static func auto() -> FunctionCallingConfig {
        return FunctionCallingConfig(value: FirebaseAILogic.FunctionCallingConfig.auto())
    }

    /// The model must call one of the specified functions.
    /// - Parameter allowedFunctionNames: The function names the model may call, or `nil` for any.
    @objc public static func any(allowedFunctionNames: [String]?) -> FunctionCallingConfig {
        return FunctionCallingConfig(value: FirebaseAILogic.FunctionCallingConfig.any(
            allowedFunctionNames: allowedFunctionNames
        ))
    }

    /// The model will not call any functions.
    @objc public static func none() -> FunctionCallingConfig {
        return FunctionCallingConfig(value: FirebaseAILogic.FunctionCallingConfig.none())
    }
}
