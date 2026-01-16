import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBAudioTranscriptionConfig)
public final class AudioTranscriptionConfig: NSObject {
    let value: FirebaseAILogic.AudioTranscriptionConfig

    init(value: FirebaseAILogic.AudioTranscriptionConfig) {
        self.value = value
        super.init()
    }

    @objc public override init() {
        self.value = FirebaseAILogic.AudioTranscriptionConfig()
        super.init()
    }
}
