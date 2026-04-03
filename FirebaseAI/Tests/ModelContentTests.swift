import Foundation
import Testing
@testable import FirebaseAILogicObjC
import FirebaseAILogic

@Suite struct ModelContentTests {
    // MARK: - TextPart round-trip

    @Test func textPartRoundTrip() {
        let textPart = FirebaseAILogicObjC.TextPart(text: "Hello, world!")
        let content = FirebaseAILogicObjC.ModelContent(parts: [textPart])

        let parts = content.parts
        #expect(parts.count == 1)
        let result = parts[0] as? FirebaseAILogicObjC.TextPart
        #expect(result != nil)
        #expect(result?.text == "Hello, world!")
    }

    // MARK: - InlineDataPart round-trip

    @Test func inlineDataPartRoundTrip() {
        let data = Data([0x01, 0x02, 0x03])
        let inlineDataPart = FirebaseAILogicObjC.InlineDataPart(data: data, mimeType: "application/octet-stream")
        let content = FirebaseAILogicObjC.ModelContent(parts: [inlineDataPart])

        let parts = content.parts
        #expect(parts.count == 1)
        let result = parts[0] as? FirebaseAILogicObjC.InlineDataPart
        #expect(result != nil)
        #expect(result?.data == data)
        #expect(result?.mimeType == "application/octet-stream")
    }

    // MARK: - FileDataPart round-trip

    @Test func fileDataPartRoundTrip() {
        let fileDataPart = FirebaseAILogicObjC.FileDataPart(uri: "gs://bucket/file.txt", mimeType: "text/plain")
        let content = FirebaseAILogicObjC.ModelContent(parts: [fileDataPart])

        let parts = content.parts
        #expect(parts.count == 1)
        let result = parts[0] as? FirebaseAILogicObjC.FileDataPart
        #expect(result != nil)
        #expect(result?.uri == "gs://bucket/file.txt")
        #expect(result?.mimeType == "text/plain")
    }

    // MARK: - FunctionCallPart round-trip

    @Test func functionCallPartRoundTrip() {
        let functionCallPart = FirebaseAILogicObjC.FunctionCallPart(
            value: FirebaseAILogic.FunctionCallPart(name: "myFunc", args: ["key": .string("value")])
        )
        let content = FirebaseAILogicObjC.ModelContent(parts: [functionCallPart])

        let parts = content.parts
        #expect(parts.count == 1)
        let result = parts[0] as? FirebaseAILogicObjC.FunctionCallPart
        #expect(result != nil)
        #expect(result?.name == "myFunc")
    }

    // MARK: - FunctionResponsePart round-trip

    @Test func functionResponsePartRoundTrip() {
        let functionResponsePart = FirebaseAILogicObjC.FunctionResponsePart(
            value: FirebaseAILogic.FunctionResponsePart(
                name: "myFunc",
                response: ["result": .string("ok")]
            )
        )
        let content = FirebaseAILogicObjC.ModelContent(parts: [functionResponsePart])

        let parts = content.parts
        #expect(parts.count == 1)
        let result = parts[0] as? FirebaseAILogicObjC.FunctionResponsePart
        #expect(result != nil)
        #expect(result?.name == "myFunc")
    }

    // MARK: - ExecutableCodePart (response-only, test getter via JSON decode)

    @Test func executableCodePartGetter() throws {
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
        #expect(parts.count == 1)
        let result = parts[0] as? FirebaseAILogicObjC.ExecutableCodePart
        #expect(result != nil)
        #expect(result?.code == "print('hello')")
    }

    // MARK: - CodeExecutionResultPart (response-only, test getter via JSON decode)

    @Test func codeExecutionResultPartGetter() throws {
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
        #expect(parts.count == 1)
        let result = parts[0] as? FirebaseAILogicObjC.CodeExecutionResultPart
        #expect(result != nil)
        #expect(result?.output == "hello")
    }

    // MARK: - Mixed parts

    @Test func mixedPartsRoundTrip() {
        let textPart = FirebaseAILogicObjC.TextPart(text: "text")
        let inlineDataPart = FirebaseAILogicObjC.InlineDataPart(data: Data([0xFF]), mimeType: "image/png")
        let fileDataPart = FirebaseAILogicObjC.FileDataPart(uri: "gs://b/f", mimeType: "text/plain")
        let content = FirebaseAILogicObjC.ModelContent(parts: [textPart, inlineDataPart, fileDataPart])

        let parts = content.parts
        #expect(parts.count == 3)
        #expect(parts[0] is FirebaseAILogicObjC.TextPart)
        #expect(parts[1] is FirebaseAILogicObjC.InlineDataPart)
        #expect(parts[2] is FirebaseAILogicObjC.FileDataPart)
    }

    // MARK: - Role

    @Test func roleIsPreserved() {
        let textPart = FirebaseAILogicObjC.TextPart(text: "hello")
        let content = FirebaseAILogicObjC.ModelContent(role: "model", parts: [textPart])
        #expect(content.role == "model")
    }

    @Test func textConvenienceInit() {
        let content = FirebaseAILogicObjC.ModelContent(text: "hello")
        #expect(content.role == "user")
        let parts = content.parts
        #expect(parts.count == 1)
        #expect((parts[0] as? FirebaseAILogicObjC.TextPart)?.text == "hello")
    }
}
