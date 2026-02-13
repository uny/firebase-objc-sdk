import FirebaseAILogic
import Foundation

/// A declaration of a function the model may call.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFunctionDeclaration)
public final class FunctionDeclaration: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.FunctionDeclaration

    init(value: FirebaseAILogic.FunctionDeclaration) {
        self.value = value
        super.init()
    }

    /// Creates a function declaration.
    /// - Parameters:
    ///   - name: The name of the function.
    ///   - description: A description of what the function does.
    ///   - parameters: A mapping of parameter names to their schemas.
    ///   - optionalParameters: Parameter names that are not required.
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
