import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFunctionResponsePart)
public final class FunctionResponsePart: NSObject {
    private static let encoder = JSONEncoder()
    let value: FirebaseAILogic.FunctionResponsePart

    init(value: FirebaseAILogic.FunctionResponsePart) {
        self.value = value
        super.init()
    }

    @objc public var name: String {
        value.name
    }

    @objc public var functionId: String? {
        value.functionId
    }

    @objc public var isThought: Bool {
        value.isThought
    }

    /// Returns the function response as a JSON-serialized Data object.
    /// Use JSONSerialization to convert to NSDictionary if needed.
    @objc public var responseData: Data? {
        return try? Self.encoder.encode(value.response)
    }
}
