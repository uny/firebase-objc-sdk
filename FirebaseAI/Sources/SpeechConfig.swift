import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBSpeechConfig)
public final class SpeechConfig: NSObject {
    let value: FirebaseAILogic.SpeechConfig

    init(value: FirebaseAILogic.SpeechConfig) {
        self.value = value
        super.init()
    }

    @objc public init(voiceName: String, languageCode: String?) {
        self.value = FirebaseAILogic.SpeechConfig(voiceName: voiceName, languageCode: languageCode)
        super.init()
    }
}
