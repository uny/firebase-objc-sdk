import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFunctionDeclaration)
public final class FunctionDeclaration: NSObject {
    let value: FirebaseAILogic.FunctionDeclaration

    init(value: FirebaseAILogic.FunctionDeclaration) {
        self.value = value
        super.init()
    }

    @objc public init(
        name: String,
        description: String,
        parameters: [String: Schema],
        optionalParameters: [String]
    ) {
        self.value = FirebaseAILogic.FunctionDeclaration(
            name: name,
            description: description,
            parameters: parameters.mapValues { $0.value },
            optionalParameters: optionalParameters
        )
        super.init()
    }
}
