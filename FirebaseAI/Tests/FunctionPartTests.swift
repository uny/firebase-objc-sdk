import Foundation
import Testing
import FirebaseAILogic
@testable import FirebaseAILogicObjC

@Suite struct FunctionPartTests {

    // MARK: - FunctionCallPart argsDictionary

    @Test func argsDictionaryReturnsCorrectValues() {
        let args: JSONObject = [
            "location": .string("Tokyo"),
            "unit": .string("celsius")
        ]
        let upstream = FirebaseAILogic.FunctionCallPart(name: "getWeather", args: args)
        let part = FunctionCallPart(value: upstream)

        let dict = part.argsDictionary
        #expect(dict != nil)
        #expect(dict?["location"] as? String == "Tokyo")
        #expect(dict?["unit"] as? String == "celsius")
    }

    @Test func argsDictionaryWithEmptyArgs() {
        let upstream = FirebaseAILogic.FunctionCallPart(name: "noArgs", args: [:])
        let part = FunctionCallPart(value: upstream)

        let dict = part.argsDictionary
        #expect(dict != nil)
        #expect(dict?.isEmpty ?? false)
    }

    @Test func argsDictionaryWithNestedObjects() {
        let args: JSONObject = [
            "config": .object(["key": .string("value"), "count": .number(42)])
        ]
        let upstream = FirebaseAILogic.FunctionCallPart(name: "configure", args: args)
        let part = FunctionCallPart(value: upstream)

        let dict = part.argsDictionary
        #expect(dict != nil)
        let config = dict?["config"] as? [String: Any]
        #expect(config?["key"] as? String == "value")
        #expect(config?["count"] as? Double == 42)
    }

    // MARK: - FunctionResponsePart responseDictionary

    @Test func responseDictionaryReturnsCorrectValues() {
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
        #expect(dict != nil)
        #expect(dict?["temperature"] as? Double == 22.5)
        #expect(dict?["condition"] as? String == "sunny")
    }

    // MARK: - FunctionCallPart properties

    @Test func functionCallPartProperties() {
        let upstream = FirebaseAILogic.FunctionCallPart(name: "myFunc", args: [:])
        let part = FunctionCallPart(value: upstream)

        #expect(part.name == "myFunc")
        #expect(!part.isThought)
    }

    // MARK: - FunctionResponsePart properties

    @Test func functionResponsePartProperties() {
        let upstream = FirebaseAILogic.FunctionResponsePart(
            name: "myFunc",
            response: [:]
        )
        let part = FunctionResponsePart(value: upstream)

        #expect(part.name == "myFunc")
        #expect(!part.isThought)
    }

    // MARK: - FunctionResponsePart public init (round-trip)

    @Test func functionResponsePartInitRoundTrip() {
        let response: [String: Any] = [
            "temperature": 22.5,
            "condition": "sunny"
        ]
        let part = FunctionResponsePart(name: "getWeather", response: response)

        #expect(part.name == "getWeather")
        let dict = part.responseDictionary
        #expect(dict != nil)
        #expect(dict?["temperature"] as? Double == 22.5)
        #expect(dict?["condition"] as? String == "sunny")
    }

    @Test func functionResponsePartInitWithFunctionId() {
        let response: [String: Any] = ["result": "ok"]
        let part = FunctionResponsePart(
            name: "doWork",
            response: response,
            functionId: "call-123"
        )

        #expect(part.name == "doWork")
        #expect(part.functionId == "call-123")
        #expect(part.responseDictionary?["result"] as? String == "ok")
    }

    @Test func functionResponsePartInitWithNilFunctionId() {
        let part = FunctionResponsePart(
            name: "doWork",
            response: ["key": "value"],
            functionId: nil
        )

        #expect(part.name == "doWork")
        #expect(part.functionId == nil)
    }

    // MARK: - FunctionCallPart public init (round-trip)

    @Test func functionCallPartInitRoundTrip() {
        let args: [String: Any] = [
            "location": "Tokyo",
            "unit": "celsius"
        ]
        let part = FunctionCallPart(name: "getWeather", args: args)

        #expect(part.name == "getWeather")
        let dict = part.argsDictionary
        #expect(dict != nil)
        #expect(dict?["location"] as? String == "Tokyo")
        #expect(dict?["unit"] as? String == "celsius")
    }

    @Test func functionCallPartInitWithId() {
        let args: [String: Any] = ["query": "test"]
        let part = FunctionCallPart(name: "search", args: args, id: "call-456")

        #expect(part.name == "search")
        #expect(part.functionId == "call-456")
        #expect(part.argsDictionary?["query"] as? String == "test")
    }

    @Test func functionCallPartInitWithNilId() {
        let part = FunctionCallPart(name: "search", args: ["q": "test"], id: nil)

        #expect(part.name == "search")
        #expect(part.functionId == nil)
    }

    // MARK: - Nested dictionary and array conversion

    @Test func nestedDictionaryConversion() {
        let args: [String: Any] = [
            "config": ["nested_key": "nested_value", "count": 42] as [String: Any]
        ]
        let part = FunctionCallPart(name: "configure", args: args)

        let dict = part.argsDictionary
        #expect(dict != nil)
        let config = dict?["config"] as? [String: Any]
        #expect(config != nil)
        #expect(config?["nested_key"] as? String == "nested_value")
        #expect(config?["count"] as? Double == 42)
    }

    @Test func arrayConversion() {
        let args: [String: Any] = [
            "tags": ["swift", "objc", "firebase"] as [Any]
        ]
        let part = FunctionCallPart(name: "tag", args: args)

        let dict = part.argsDictionary
        #expect(dict != nil)
        let tags = dict?["tags"] as? [String]
        #expect(tags == ["swift", "objc", "firebase"])
    }

    @Test func mixedNestedStructure() {
        let response: [String: Any] = [
            "results": [
                ["name": "item1", "score": 0.95] as [String: Any],
                ["name": "item2", "score": 0.87] as [String: Any]
            ] as [Any],
            "total": 2
        ]
        let part = FunctionResponsePart(name: "search", response: response)

        let dict = part.responseDictionary
        #expect(dict != nil)
        #expect(dict?["total"] as? Double == 2)
        let results = dict?["results"] as? [[String: Any]]
        #expect(results?.count == 2)
        #expect(results?[0]["name"] as? String == "item1")
        #expect(results?[0]["score"] as? Double == 0.95)
    }

    // MARK: - JSONValueConversion edge cases

    @Test func nsNullConversion() {
        let args: [String: Any] = [
            "optional_field": NSNull()
        ]
        let part = FunctionCallPart(name: "test", args: args)

        let dict = part.argsDictionary
        #expect(dict != nil)
        #expect(dict?["optional_field"] is NSNull)
    }

    @Test func boolConversion() {
        let args: [String: Any] = [
            "enabled": true,
            "count": NSNumber(value: 42)
        ]
        let part = FunctionCallPart(name: "test", args: args)

        let dict = part.argsDictionary
        #expect(dict != nil)
        #expect(dict?["enabled"] as? Bool == true)
        #expect(dict?["count"] as? Double == 42)
    }

    @Test func emptyDictionaryConversion() {
        let emptyResponse: [String: Any] = [:]
        let part = FunctionResponsePart(name: "empty", response: emptyResponse)

        #expect(part.name == "empty")
        let dict = part.responseDictionary
        #expect(dict != nil)
        #expect(dict?.isEmpty ?? false)
    }
}
