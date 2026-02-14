import XCTest
@testable import FirebaseAILogicObjC
import FirebaseAILogic

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
final class ModelContentTests: XCTestCase {
    // MARK: - TextPart round-trip

    func testTextPartRoundTrip() {
        let textPart = FirebaseAILogicObjC.TextPart(text: "Hello, world!")
        let content = FirebaseAILogicObjC.ModelContent(parts: [textPart])

        let parts = content.parts
        XCTAssertEqual(parts.count, 1)
        let result = parts[0] as? FirebaseAILogicObjC.TextPart
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.text, "Hello, world!")
    }

    // MARK: - InlineDataPart round-trip

    func testInlineDataPartRoundTrip() {
        let data = Data([0x01, 0x02, 0x03])
        let inlineDataPart = FirebaseAILogicObjC.InlineDataPart(data: data, mimeType: "application/octet-stream")
        let content = FirebaseAILogicObjC.ModelContent(parts: [inlineDataPart])

        let parts = content.parts
        XCTAssertEqual(parts.count, 1)
        let result = parts[0] as? FirebaseAILogicObjC.InlineDataPart
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.data, data)
        XCTAssertEqual(result?.mimeType, "application/octet-stream")
    }

    // MARK: - FileDataPart round-trip

    func testFileDataPartRoundTrip() {
        let fileDataPart = FirebaseAILogicObjC.FileDataPart(uri: "gs://bucket/file.txt", mimeType: "text/plain")
        let content = FirebaseAILogicObjC.ModelContent(parts: [fileDataPart])

        let parts = content.parts
        XCTAssertEqual(parts.count, 1)
        let result = parts[0] as? FirebaseAILogicObjC.FileDataPart
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.uri, "gs://bucket/file.txt")
        XCTAssertEqual(result?.mimeType, "text/plain")
    }

    // MARK: - FunctionCallPart round-trip

    func testFunctionCallPartRoundTrip() {
        let functionCallPart = FirebaseAILogicObjC.FunctionCallPart(
            value: FirebaseAILogic.FunctionCallPart(name: "myFunc", args: ["key": .string("value")])
        )
        let content = FirebaseAILogicObjC.ModelContent(parts: [functionCallPart])

        let parts = content.parts
        XCTAssertEqual(parts.count, 1)
        let result = parts[0] as? FirebaseAILogicObjC.FunctionCallPart
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "myFunc")
    }

    // MARK: - FunctionResponsePart round-trip

    func testFunctionResponsePartRoundTrip() {
        let functionResponsePart = FirebaseAILogicObjC.FunctionResponsePart(
            value: FirebaseAILogic.FunctionResponsePart(
                name: "myFunc",
                response: ["result": .string("ok")]
            )
        )
        let content = FirebaseAILogicObjC.ModelContent(parts: [functionResponsePart])

        let parts = content.parts
        XCTAssertEqual(parts.count, 1)
        let result = parts[0] as? FirebaseAILogicObjC.FunctionResponsePart
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "myFunc")
    }

    // MARK: - ExecutableCodePart (response-only, test getter via JSON decode)

    func testExecutableCodePartGetter() throws {
        let jsonString = """
        {
            "role": "model",
            "parts": [
                {
                    "executableCode": {
                        "language": "PYTHON",
                        "code": "print('hello')"
                    }
                }
            ]
        }
        """
        let json = Data(jsonString.utf8)
        let swiftContent = try JSONDecoder().decode(FirebaseAILogic.ModelContent.self, from: json)
        let content = FirebaseAILogicObjC.ModelContent(value: swiftContent)

        let parts = content.parts
        XCTAssertEqual(parts.count, 1)
        let result = parts[0] as? FirebaseAILogicObjC.ExecutableCodePart
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.code, "print('hello')")
    }

    // MARK: - CodeExecutionResultPart (response-only, test getter via JSON decode)

    func testCodeExecutionResultPartGetter() throws {
        let jsonString = """
        {
            "role": "model",
            "parts": [
                {
                    "codeExecutionResult": {
                        "outcome": "OUTCOME_OK",
                        "output": "hello"
                    }
                }
            ]
        }
        """
        let json = Data(jsonString.utf8)
        let swiftContent = try JSONDecoder().decode(FirebaseAILogic.ModelContent.self, from: json)
        let content = FirebaseAILogicObjC.ModelContent(value: swiftContent)

        let parts = content.parts
        XCTAssertEqual(parts.count, 1)
        let result = parts[0] as? FirebaseAILogicObjC.CodeExecutionResultPart
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.output, "hello")
    }

    // MARK: - Mixed parts

    func testMixedPartsRoundTrip() {
        let textPart = FirebaseAILogicObjC.TextPart(text: "text")
        let inlineDataPart = FirebaseAILogicObjC.InlineDataPart(data: Data([0xFF]), mimeType: "image/png")
        let fileDataPart = FirebaseAILogicObjC.FileDataPart(uri: "gs://b/f", mimeType: "text/plain")
        let content = FirebaseAILogicObjC.ModelContent(parts: [textPart, inlineDataPart, fileDataPart])

        let parts = content.parts
        XCTAssertEqual(parts.count, 3)
        XCTAssertTrue(parts[0] is FirebaseAILogicObjC.TextPart)
        XCTAssertTrue(parts[1] is FirebaseAILogicObjC.InlineDataPart)
        XCTAssertTrue(parts[2] is FirebaseAILogicObjC.FileDataPart)
    }

    // MARK: - Role

    func testRoleIsPreserved() {
        let textPart = FirebaseAILogicObjC.TextPart(text: "hello")
        let content = FirebaseAILogicObjC.ModelContent(role: "model", parts: [textPart])
        XCTAssertEqual(content.role, "model")
    }

    func testTextConvenienceInit() {
        let content = FirebaseAILogicObjC.ModelContent(text: "hello")
        XCTAssertEqual(content.role, "user")
        let parts = content.parts
        XCTAssertEqual(parts.count, 1)
        XCTAssertEqual((parts[0] as? FirebaseAILogicObjC.TextPart)?.text, "hello")
    }
}
