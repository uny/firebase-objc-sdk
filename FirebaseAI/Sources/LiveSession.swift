import FirebaseAILogic
import Foundation

/// An active live session for bidirectional streaming.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveSession)
public final class LiveSession: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.LiveSession

    init(value: FirebaseAILogic.LiveSession) {
        self.value = value
        super.init()
    }

    /// Sends function responses to the server.
    @objc public func sendFunctionResponses(_ responses: [FunctionResponsePart]) async {
        await value.sendFunctionResponses(responses.map { $0.value })
    }

    /// Sends real-time audio data to the server.
    @objc public func sendAudioRealtime(_ audio: Data) async {
        await value.sendAudioRealtime(audio)
    }

    /// Sends real-time video data to the server.
    @objc public func sendVideoRealtime(_ video: Data, mimeType: String) async {
        await value.sendVideoRealtime(video, mimeType: mimeType)
    }

    /// Sends real-time text to the server.
    @objc public func sendTextRealtime(_ text: String) async {
        await value.sendTextRealtime(text)
    }

    /// Sends content to the server, optionally marking the turn as complete.
    @objc public func sendContent(_ content: [ModelContent], turnComplete: Bool) async {
        await value.sendContent(content.map { $0.value }, turnComplete: turnComplete)
    }

    /// Returns a stream of messages received from the server.
    @objc public func responses() -> LiveServerMessageStream {
        LiveServerMessageStream(stream: value.responses)
    }

    /// Resumes a previously disconnected session.
    @objc public func resumeSession() async throws {
        try await value.resumeSession()
    }

    /// Resumes a previously disconnected session with the given resumption config.
    /// - Parameter sessionResumption: The session resumption configuration.
    @objc public func resumeSession(sessionResumption: SessionResumptionConfig) async throws {
        try await value.resumeSession(sessionResumption: sessionResumption.value)
    }

    /// Closes the live session.
    @objc public func close() async {
        await value.close()
    }
}
