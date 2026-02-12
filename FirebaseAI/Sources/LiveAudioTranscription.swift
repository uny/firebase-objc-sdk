import FirebaseAILogic
import Foundation

/// A wrapper for live audio transcription data.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveAudioTranscription)
public final class LiveAudioTranscription: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.LiveAudioTranscription

    init(value: FirebaseAILogic.LiveAudioTranscription) {
        self.value = value
        super.init()
    }

    /// The transcribed text, if available.
    @objc public var text: String? {
        value.text
    }
}
