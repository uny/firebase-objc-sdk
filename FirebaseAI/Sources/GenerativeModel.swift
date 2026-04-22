import FirebaseAILogic
import Foundation

/// A model that generates content from a prompt.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerativeModel)
public final class GenerativeModel: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.GenerativeModel

    init(value: FirebaseAILogic.GenerativeModel) {
        self.value = value
        super.init()
    }

    /// Generates content from an array of ModelContent objects.
    @objc public func generateContent(_ content: [ModelContent]) async throws -> GenerateContentResponse {
        try await mapFirebaseAIErrors {
            GenerateContentResponse(value: try await value.generateContent(content.map { $0.value }))
        }
    }

    /// Generates content from a single text prompt.
    @objc public func generateContentFromText(_ text: String) async throws -> GenerateContentResponse {
        try await mapFirebaseAIErrors {
            GenerateContentResponse(value: try await value.generateContent(text))
        }
    }

    /// Counts tokens for the given content.
    @objc public func countTokens(_ content: [ModelContent]) async throws -> CountTokensResponse {
        try await mapFirebaseAIErrors {
            CountTokensResponse(value: try await value.countTokens(content.map { $0.value }))
        }
    }

    /// Counts tokens for a single text prompt.
    @objc public func countTokensFromText(_ text: String) async throws -> CountTokensResponse {
        try await mapFirebaseAIErrors {
            CountTokensResponse(value: try await value.countTokens(text))
        }
    }

    /// Returns a stream that generates content from an array of ModelContent objects.
    @objc public func generateContentStream(_ content: [ModelContent]) throws -> ContentStream {
        try mapFirebaseAIErrors {
            ContentStream(stream: try value.generateContentStream(content.map { $0.value }))
        }
    }

    /// Returns a stream that generates content from a single text prompt.
    @objc public func generateContentStreamFromText(_ text: String) throws -> ContentStream {
        try mapFirebaseAIErrors {
            ContentStream(stream: try value.generateContentStream(text))
        }
    }

    /// Starts a new chat session with the given history.
    @objc public func startChat(history: [ModelContent]) -> Chat {
        let chat = value.startChat(history: history.map { $0.value })
        return Chat(value: chat)
    }

    /// Starts a new chat session with empty history.
    @objc public func startChat() -> Chat {
        let chat = value.startChat()
        return Chat(value: chat)
    }
}
