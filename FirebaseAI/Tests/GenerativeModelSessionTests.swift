#if compiler(>=6.2.3)
import Foundation
import Testing
import FirebaseAILogic
@testable import FirebaseAILogicObjC

@Suite struct GenerativeModelSessionTests {

    // MARK: - SessionResponse

    @Test func sessionResponseProperties() throws {
        let jsonString = """
        {
            "candidates": [{
                "content": {
                    "role": "model",
                    "parts": [{"text": "Hello from model"}]
                }
            }]
        }
        """
        let upstreamResponse = try JSONDecoder().decode(
            FirebaseAILogic.GenerateContentResponse.self, from: Data(jsonString.utf8)
        )
        let rawResponse = GenerateContentResponse(value: upstreamResponse)
        let sessionResponse = SessionResponse(content: "Hello from model", rawResponse: rawResponse)

        #expect(sessionResponse.content == "Hello from model")
        #expect(sessionResponse.rawResponse === rawResponse)
        #expect(sessionResponse.rawResponse.text == "Hello from model")
    }

    @Test func sessionResponseWithEmptyContent() throws {
        let jsonString = """
        {
            "candidates": [{
                "content": {
                    "role": "model",
                    "parts": [{"text": ""}]
                }
            }]
        }
        """
        let upstreamResponse = try JSONDecoder().decode(
            FirebaseAILogic.GenerateContentResponse.self, from: Data(jsonString.utf8)
        )
        let rawResponse = GenerateContentResponse(value: upstreamResponse)
        let sessionResponse = SessionResponse(content: "", rawResponse: rawResponse)

        #expect(sessionResponse.content == "")
        #expect(sessionResponse.rawResponse === rawResponse)
    }
}
#endif
