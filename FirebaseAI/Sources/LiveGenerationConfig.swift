import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveGenerationConfig)
public final class LiveGenerationConfig: NSObject {
    let value: FirebaseAILogic.LiveGenerationConfig

    init(value: FirebaseAILogic.LiveGenerationConfig) {
        self.value = value
        super.init()
    }

    @objc public init(
        temperature: NSNumber?,
        topP: NSNumber?,
        topK: NSNumber?,
        candidateCount: NSNumber?,
        maxOutputTokens: NSNumber?,
        presencePenalty: NSNumber?,
        frequencyPenalty: NSNumber?,
        responseModalities: [ResponseModality]?,
        speech: SpeechConfig?,
        inputAudioTranscription: AudioTranscriptionConfig?,
        outputAudioTranscription: AudioTranscriptionConfig?
    ) {
        self.value = FirebaseAILogic.LiveGenerationConfig(
            temperature: temperature?.floatValue,
            topP: topP?.floatValue,
            topK: topK?.intValue,
            candidateCount: candidateCount?.intValue,
            maxOutputTokens: maxOutputTokens?.intValue,
            presencePenalty: presencePenalty?.floatValue,
            frequencyPenalty: frequencyPenalty?.floatValue,
            responseModalities: responseModalities?.map { $0.value },
            speech: speech?.value,
            inputAudioTranscription: inputAudioTranscription?.value,
            outputAudioTranscription: outputAudioTranscription?.value
        )
        super.init()
    }
}
