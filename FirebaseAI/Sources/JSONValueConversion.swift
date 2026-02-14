import FirebaseAILogic
import Foundation

/// Converts a `[String: Any]` dictionary (e.g. from `NSDictionary`) to a `JSONObject`.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
func convertToJSONObject(_ dictionary: [String: Any]) -> JSONObject {
    dictionary.compactMapValues { convertToJSONValue($0) }
}

/// Converts an arbitrary value to a `JSONValue`.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
func convertToJSONValue(_ value: Any) -> JSONValue {
    switch value {
    case is NSNull:
        return .null
    case let bool as Bool:
        return .bool(bool)
    case let number as NSNumber:
        return .number(number.doubleValue)
    case let string as String:
        return .string(string)
    case let array as [Any]:
        return .array(array.map { convertToJSONValue($0) })
    case let dict as [String: Any]:
        return .object(convertToJSONObject(dict))
    default:
        return .null
    }
}
