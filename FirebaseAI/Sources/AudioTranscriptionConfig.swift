import FirebaseAILogic
import Foundation

/// Configuration for audio transcription in live sessions.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBAudioTranscriptionConfig)
public final class AudioTranscriptionConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.AudioTranscriptionConfig

    init(value: FirebaseAILogic.AudioTranscriptionConfig) {
        self.value = value
        super.init()
    }

    @objc override public init() {
        self.value = FirebaseAILogic.AudioTranscriptionConfig()
        super.init()
    }
}
