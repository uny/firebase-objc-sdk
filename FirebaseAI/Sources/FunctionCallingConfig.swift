import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFunctionCallingConfig)
public final class FunctionCallingConfig: NSObject {
    let value: FirebaseAILogic.FunctionCallingConfig

    init(value: FirebaseAILogic.FunctionCallingConfig) {
        self.value = value
        super.init()
    }

    @objc public static func auto() -> FunctionCallingConfig {
        return FunctionCallingConfig(value: FirebaseAILogic.FunctionCallingConfig.auto())
    }

    @objc public static func any(allowedFunctionNames: [String]?) -> FunctionCallingConfig {
        return FunctionCallingConfig(value: FirebaseAILogic.FunctionCallingConfig.any(
            allowedFunctionNames: allowedFunctionNames
        ))
    }

    @objc public static func none() -> FunctionCallingConfig {
        return FunctionCallingConfig(value: FirebaseAILogic.FunctionCallingConfig.none())
    }
}
