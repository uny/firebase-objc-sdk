import FirebaseAILogic
import Foundation

/// A part representing a function call from the model.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFunctionCallPart)
public final class FunctionCallPart: NSObject, @unchecked Sendable {
    private static let encoder = JSONEncoder()
    let value: FirebaseAILogic.FunctionCallPart

    init(value: FirebaseAILogic.FunctionCallPart) {
        self.value = value
        super.init()
    }

    /// The name of the function to call.
    @objc public var name: String {
        value.name
    }

    /// An optional identifier for this function call.
    @objc public var functionId: String? {
        value.functionId
    }

    /// Whether this part is a model thought.
    @objc public var isThought: Bool {
        value.isThought
    }

    /// Returns the function arguments as a JSON-serialized Data object.
    /// Use JSONSerialization to convert to NSDictionary if needed.
    @objc public var argsData: Data? {
        return try? Self.encoder.encode(value.args)
    }

    /// Returns the function arguments as a dictionary.
    @objc public var argsDictionary: [String: Any]? {
        guard let data = argsData else { return nil }
        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }

    /// Creates a function call part with a name and arguments dictionary.
    /// - Parameters:
    ///   - name: The name of the function to call.
    ///   - args: The function arguments as a dictionary.
    @objc public convenience init(name: String, args: [String: Any]) {
        let jsonObject = convertToJSONObject(args)
        self.init(value: FirebaseAILogic.FunctionCallPart(name: name, args: jsonObject))
    }

    /// Creates a function call part with a name, arguments dictionary, and optional ID.
    /// - Parameters:
    ///   - name: The name of the function to call.
    ///   - args: The function arguments as a dictionary.
    ///   - id: An optional identifier for this function call.
    @objc public convenience init(name: String, args: [String: Any], id: String?) {
        let jsonObject = convertToJSONObject(args)
        self.init(value: FirebaseAILogic.FunctionCallPart(name: name, args: jsonObject, id: id))
    }
}
