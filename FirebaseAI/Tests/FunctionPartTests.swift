import XCTest
import FirebaseAILogic
@testable import FirebaseAILogicObjC

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
final class FunctionPartTests: XCTestCase {

    // MARK: - FunctionCallPart argsDictionary

    func testArgsDictionaryReturnsCorrectValues() {
        let args: JSONObject = [
            "location": .string("Tokyo"),
            "unit": .string("celsius")
        ]
        let upstream = FirebaseAILogic.FunctionCallPart(name: "getWeather", args: args)
        let part = FunctionCallPart(value: upstream)

        let dict = part.argsDictionary
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict?["location"] as? String, "Tokyo")
        XCTAssertEqual(dict?["unit"] as? String, "celsius")
    }

    func testArgsDictionaryWithEmptyArgs() {
        let upstream = FirebaseAILogic.FunctionCallPart(name: "noArgs", args: [:])
        let part = FunctionCallPart(value: upstream)

        let dict = part.argsDictionary
        XCTAssertNotNil(dict)
        XCTAssertTrue(dict?.isEmpty ?? false)
    }

    func testArgsDictionaryWithNestedObjects() {
        let args: JSONObject = [
            "config": .object(["key": .string("value"), "count": .number(42)])
        ]
        let upstream = FirebaseAILogic.FunctionCallPart(name: "configure", args: args)
        let part = FunctionCallPart(value: upstream)

        let dict = part.argsDictionary
        XCTAssertNotNil(dict)
        let config = dict?["config"] as? [String: Any]
        XCTAssertEqual(config?["key"] as? String, "value")
        XCTAssertEqual(config?["count"] as? Double, 42)
    }

    // MARK: - FunctionResponsePart responseDictionary

    func testResponseDictionaryReturnsCorrectValues() {
        let response: JSONObject = [
            "temperature": .number(22.5),
            "condition": .string("sunny")
        ]
        let upstream = FirebaseAILogic.FunctionResponsePart(
            name: "getWeather",
            response: response
        )
        let part = FunctionResponsePart(value: upstream)

        let dict = part.responseDictionary
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict?["temperature"] as? Double, 22.5)
        XCTAssertEqual(dict?["condition"] as? String, "sunny")
    }

    // MARK: - FunctionCallPart properties

    func testFunctionCallPartProperties() {
        let upstream = FirebaseAILogic.FunctionCallPart(name: "myFunc", args: [:])
        let part = FunctionCallPart(value: upstream)

        XCTAssertEqual(part.name, "myFunc")
        XCTAssertFalse(part.isThought)
    }

    // MARK: - FunctionResponsePart properties

    func testFunctionResponsePartProperties() {
        let upstream = FirebaseAILogic.FunctionResponsePart(
            name: "myFunc",
            response: [:]
        )
        let part = FunctionResponsePart(value: upstream)

        XCTAssertEqual(part.name, "myFunc")
        XCTAssertFalse(part.isThought)
    }

    // MARK: - FunctionResponsePart public init (round-trip)

    func testFunctionResponsePartInitRoundTrip() {
        let response: [String: Any] = [
            "temperature": 22.5,
            "condition": "sunny"
        ]
        let part = FunctionResponsePart(name: "getWeather", response: response)

        XCTAssertEqual(part.name, "getWeather")
        let dict = part.responseDictionary
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict?["temperature"] as? Double, 22.5)
        XCTAssertEqual(dict?["condition"] as? String, "sunny")
    }

    func testFunctionResponsePartInitWithFunctionId() {
        let response: [String: Any] = ["result": "ok"]
        let part = FunctionResponsePart(
            name: "doWork",
            response: response,
            functionId: "call-123"
        )

        XCTAssertEqual(part.name, "doWork")
        XCTAssertEqual(part.functionId, "call-123")
        XCTAssertEqual(part.responseDictionary?["result"] as? String, "ok")
    }

    func testFunctionResponsePartInitWithNilFunctionId() {
        let part = FunctionResponsePart(
            name: "doWork",
            response: ["key": "value"],
            functionId: nil
        )

        XCTAssertEqual(part.name, "doWork")
        XCTAssertNil(part.functionId)
    }

    // MARK: - FunctionCallPart public init (round-trip)

    func testFunctionCallPartInitRoundTrip() {
        let args: [String: Any] = [
            "location": "Tokyo",
            "unit": "celsius"
        ]
        let part = FunctionCallPart(name: "getWeather", args: args)

        XCTAssertEqual(part.name, "getWeather")
        let dict = part.argsDictionary
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict?["location"] as? String, "Tokyo")
        XCTAssertEqual(dict?["unit"] as? String, "celsius")
    }

    func testFunctionCallPartInitWithId() {
        let args: [String: Any] = ["query": "test"]
        let part = FunctionCallPart(name: "search", args: args, id: "call-456")

        XCTAssertEqual(part.name, "search")
        XCTAssertEqual(part.functionId, "call-456")
        XCTAssertEqual(part.argsDictionary?["query"] as? String, "test")
    }

    func testFunctionCallPartInitWithNilId() {
        let part = FunctionCallPart(name: "search", args: ["q": "test"], id: nil)

        XCTAssertEqual(part.name, "search")
        XCTAssertNil(part.functionId)
    }

    // MARK: - Nested dictionary and array conversion

    func testNestedDictionaryConversion() {
        let args: [String: Any] = [
            "config": ["nested_key": "nested_value", "count": 42] as [String: Any]
        ]
        let part = FunctionCallPart(name: "configure", args: args)

        let dict = part.argsDictionary
        XCTAssertNotNil(dict)
        let config = dict?["config"] as? [String: Any]
        XCTAssertNotNil(config)
        XCTAssertEqual(config?["nested_key"] as? String, "nested_value")
        XCTAssertEqual(config?["count"] as? Double, 42)
    }

    func testArrayConversion() {
        let args: [String: Any] = [
            "tags": ["swift", "objc", "firebase"] as [Any]
        ]
        let part = FunctionCallPart(name: "tag", args: args)

        let dict = part.argsDictionary
        XCTAssertNotNil(dict)
        let tags = dict?["tags"] as? [String]
        XCTAssertEqual(tags, ["swift", "objc", "firebase"])
    }

    func testMixedNestedStructure() {
        let response: [String: Any] = [
            "results": [
                ["name": "item1", "score": 0.95] as [String: Any],
                ["name": "item2", "score": 0.87] as [String: Any]
            ] as [Any],
            "total": 2
        ]
        let part = FunctionResponsePart(name: "search", response: response)

        let dict = part.responseDictionary
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict?["total"] as? Double, 2)
        let results = dict?["results"] as? [[String: Any]]
        XCTAssertEqual(results?.count, 2)
        XCTAssertEqual(results?[0]["name"] as? String, "item1")
        XCTAssertEqual(results?[0]["score"] as? Double, 0.95)
    }

    // MARK: - JSONValueConversion edge cases

    func testNSNullConversion() {
        let args: [String: Any] = [
            "optional_field": NSNull()
        ]
        let part = FunctionCallPart(name: "test", args: args)

        let dict = part.argsDictionary
        XCTAssertNotNil(dict)
        // NSNull converts to JSONValue.null, which serializes as JSON null
        XCTAssertTrue(dict?["optional_field"] is NSNull)
    }

    func testBoolConversion() {
        // In Swift/ObjC, Bool and NSNumber can be ambiguous.
        // Ensure Bool is preserved as Bool (not number).
        let args: [String: Any] = [
            "enabled": true,
            "count": NSNumber(value: 42)
        ]
        let part = FunctionCallPart(name: "test", args: args)

        let dict = part.argsDictionary
        XCTAssertNotNil(dict)
        // Bool should round-trip as a boolean value
        XCTAssertEqual(dict?["enabled"] as? Bool, true)
        XCTAssertEqual(dict?["count"] as? Double, 42)
    }

    func testEmptyDictionaryConversion() {
        let emptyResponse: [String: Any] = [:]
        let part = FunctionResponsePart(name: "empty", response: emptyResponse)

        XCTAssertEqual(part.name, "empty")
        let dict = part.responseDictionary
        XCTAssertNotNil(dict)
        XCTAssertTrue(dict?.isEmpty ?? false)
    }
}
