import FirebaseAILogic
import Foundation

/// A part representing a function response to the model.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFunctionResponsePart)
public final class FunctionResponsePart: NSObject, @unchecked Sendable {
    private static let encoder = JSONEncoder()
    let value: FirebaseAILogic.FunctionResponsePart

    init(value: FirebaseAILogic.FunctionResponsePart) {
        self.value = value
        super.init()
    }

    /// The name of the function that was called.
    @objc public var name: String {
        value.name
    }

    /// An optional identifier for this function response.
    @objc public var functionId: String? {
        value.functionId
    }

    /// Whether this part is a model thought.
    @objc public var isThought: Bool {
        value.isThought
    }

    /// Returns the function response as a JSON-serialized Data object.
    /// Use JSONSerialization to convert to NSDictionary if needed.
    @objc public var responseData: Data? {
        return try? Self.encoder.encode(value.response)
    }

    /// Returns the function response as a dictionary.
    @objc public var responseDictionary: [String: Any]? {
        guard let data = responseData else { return nil }
        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }

    /// Creates a function response part with a name and response dictionary.
    /// - Parameters:
    ///   - name: The name of the function that was called.
    ///   - response: The function's response as a dictionary.
    @objc public convenience init(name: String, response: [String: Any]) {
        let jsonObject = convertToJSONObject(response)
        self.init(value: FirebaseAILogic.FunctionResponsePart(name: name, response: jsonObject))
    }

    /// Creates a function response part with a name, response dictionary, and optional function ID.
    /// - Parameters:
    ///   - name: The name of the function that was called.
    ///   - response: The function's response as a dictionary.
    ///   - functionId: An optional identifier matching the function call.
    @objc public convenience init(name: String, response: [String: Any], functionId: String?) {
        let jsonObject = convertToJSONObject(response)
        self.init(value: FirebaseAILogic.FunctionResponsePart(
            name: name, response: jsonObject, functionId: functionId
        ))
    }
}
