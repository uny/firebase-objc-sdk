import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveSession)
public final class LiveSession: NSObject {
    let value: FirebaseAILogic.LiveSession

    init(value: FirebaseAILogic.LiveSession) {
        self.value = value
        super.init()
    }

    @objc public func sendFunctionResponses(_ responses: [FunctionResponsePart]) async {
        await value.sendFunctionResponses(responses.map { $0.value })
    }

    @objc public func sendAudioRealtime(_ audio: Data) async {
        await value.sendAudioRealtime(audio)
    }

    @objc public func sendVideoRealtime(_ video: Data, mimeType: String) async {
        await value.sendVideoRealtime(video, mimeType: mimeType)
    }

    @objc public func sendTextRealtime(_ text: String) async {
        await value.sendTextRealtime(text)
    }

    @objc public func sendContent(_ content: [ModelContent], turnComplete: Bool) async {
        await value.sendContent(content.map { $0.value }, turnComplete: turnComplete)
    }

    @objc public func close() async {
        await value.close()
    }
}
