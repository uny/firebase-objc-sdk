import FirebaseAILogic
import Foundation

/// Configuration for speech synthesis in live sessions.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBSpeechConfig)
public final class SpeechConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.SpeechConfig

    init(value: FirebaseAILogic.SpeechConfig) {
        self.value = value
        super.init()
    }

    /// Creates a speech configuration.
    /// - Parameters:
    ///   - voiceName: The name of the voice to use.
    ///   - languageCode: The BCP-47 language code, or `nil` for auto-detection.
    @objc public init(voiceName: String, languageCode: String?) {
        self.value = FirebaseAILogic.SpeechConfig(voiceName: voiceName, languageCode: languageCode)
        super.init()
    }
}
