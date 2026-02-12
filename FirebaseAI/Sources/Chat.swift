import FirebaseAILogic
import Foundation

/// A multi-turn chat session with a generative model.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBChat)
public final class Chat: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.Chat

    init(value: FirebaseAILogic.Chat) {
        self.value = value
        super.init()
    }

    /// The chat history.
    @objc public var history: [ModelContent] {
        get {
            value.history.map { ModelContent(value: $0) }
        }
        set {
            value.history = newValue.map { $0.value }
        }
    }

    /// Sends a message and returns the response.
    @objc public func sendMessage(_ content: [ModelContent]) async throws -> GenerateContentResponse {
        let response = try await value.sendMessage(content.map { $0.value })
        return GenerateContentResponse(value: response)
    }

    /// Sends a text message and returns the response.
    @objc public func sendMessageText(_ text: String) async throws -> GenerateContentResponse {
        let response = try await value.sendMessage(text)
        return GenerateContentResponse(value: response)
    }

    /// Returns a stream that sends a message from an array of ModelContent objects.
    @objc public func sendMessageStream(_ content: [ModelContent]) throws -> ContentStream {
        let stream = try value.sendMessageStream(content.map { $0.value })
        return ContentStream(stream: stream)
    }

    /// Returns a stream that sends a text message.
    @objc public func sendMessageStreamText(_ text: String) throws -> ContentStream {
        let stream = try value.sendMessageStream(text)
        return ContentStream(stream: stream)
    }
}
