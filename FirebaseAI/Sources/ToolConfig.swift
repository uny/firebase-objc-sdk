import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBToolConfig)
public final class ToolConfig: NSObject {
    let value: FirebaseAILogic.ToolConfig

    init(value: FirebaseAILogic.ToolConfig) {
        self.value = value
        super.init()
    }

    @objc public init(functionCallingConfig: FunctionCallingConfig?) {
        self.value = FirebaseAILogic.ToolConfig(
            functionCallingConfig: functionCallingConfig?.value
        )
        super.init()
    }
}
