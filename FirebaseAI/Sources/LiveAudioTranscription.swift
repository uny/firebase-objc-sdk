import FirebaseAILogic
import Foundation

/// A wrapper for live audio transcription data.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveAudioTranscription)
public final class LiveAudioTranscription: NSObject, @unchecked Sendable {
    let wrapped: FirebaseAILogic.LiveAudioTranscription

    init(wrapped: FirebaseAILogic.LiveAudioTranscription) {
        self.wrapped = wrapped
        super.init()
    }

    /// The transcribed text, if available.
    @objc public var text: String? {
        wrapped.text
    }
}
