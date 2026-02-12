import XCTest
import FirebaseAILogic
@testable import FirebaseAILogicObjC

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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
}
