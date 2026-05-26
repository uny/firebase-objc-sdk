import FirebaseAILogic
import Foundation

/// Configuration for live generation sessions.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveGenerationConfig)
public final class LiveGenerationConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.LiveGenerationConfig

    // Stored copies of init parameters (upstream properties are internal).
    private let _temperature: NSNumber?
    private let _topP: NSNumber?
    private let _topK: NSNumber?
    private let _candidateCount: NSNumber?
    private let _maxOutputTokens: NSNumber?
    private let _presencePenalty: NSNumber?
    private let _frequencyPenalty: NSNumber?
    private let _responseModalities: [ResponseModality]?
    private let _speech: SpeechConfig?
    private let _inputAudioTranscription: AudioTranscriptionConfig?
    private let _outputAudioTranscription: AudioTranscriptionConfig?
    private let _contextWindowCompression: ContextWindowCompressionConfig?

    init(value: FirebaseAILogic.LiveGenerationConfig) {
        self.value = value
        _temperature = nil
        _topP = nil
        _topK = nil
        _candidateCount = nil
        _maxOutputTokens = nil
        _presencePenalty = nil
        _frequencyPenalty = nil
        _responseModalities = nil
        _speech = nil
        _inputAudioTranscription = nil
        _outputAudioTranscription = nil
        _contextWindowCompression = nil
        super.init()
    }

    @objc public convenience init(
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
        outputAudioTranscription: AudioTranscriptionConfig?,
        contextWindowCompression: ContextWindowCompressionConfig?
    ) {
        let config = FirebaseAILogic.LiveGenerationConfig(
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
            outputAudioTranscription: outputAudioTranscription?.value,
            contextWindowCompression: contextWindowCompression?.value
        )
        self.init(value: config,
                  temperature: temperature,
                  topP: topP,
                  topK: topK,
                  candidateCount: candidateCount,
                  maxOutputTokens: maxOutputTokens,
                  presencePenalty: presencePenalty,
                  frequencyPenalty: frequencyPenalty,
                  responseModalities: responseModalities,
                  speech: speech,
                  inputAudioTranscription: inputAudioTranscription,
                  outputAudioTranscription: outputAudioTranscription,
                  contextWindowCompression: contextWindowCompression)
    }

    private init(
        value: FirebaseAILogic.LiveGenerationConfig,
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
        outputAudioTranscription: AudioTranscriptionConfig?,
        contextWindowCompression: ContextWindowCompressionConfig?
    ) {
        self.value = value
        _temperature = temperature
        _topP = topP
        _topK = topK
        _candidateCount = candidateCount
        _maxOutputTokens = maxOutputTokens
        _presencePenalty = presencePenalty
        _frequencyPenalty = frequencyPenalty
        _responseModalities = responseModalities
        _speech = speech
        _inputAudioTranscription = inputAudioTranscription
        _outputAudioTranscription = outputAudioTranscription
        _contextWindowCompression = contextWindowCompression
        super.init()
    }

    // MARK: - Read Properties

    /// Controls the degree of randomness in token selection, or `nil` if not set.
    @objc public var temperature: NSNumber? { _temperature }

    /// Controls diversity of generated text, or `nil` if not set.
    @objc public var topP: NSNumber? { _topP }

    /// Limits the number of highest probability words considered, or `nil` if not set.
    @objc public var topK: NSNumber? { _topK }

    /// The number of response variations to return, or `nil` if not set.
    @objc public var candidateCount: NSNumber? { _candidateCount }

    /// Maximum number of tokens that can be generated in the response, or `nil` if not set.
    @objc public var maxOutputTokens: NSNumber? { _maxOutputTokens }

    /// Controls the likelihood of repeating the same words or phrases, or `nil` if not set.
    @objc public var presencePenalty: NSNumber? { _presencePenalty }

    /// Controls the likelihood of repeating words with increasing penalty, or `nil` if not set.
    @objc public var frequencyPenalty: NSNumber? { _frequencyPenalty }

    /// Supported modalities of the response, or `nil` if not set.
    @objc public var responseModalities: [ResponseModality]? { _responseModalities }

    /// Speech configuration for the session, or `nil` if not set.
    @objc public var speech: SpeechConfig? { _speech }

    /// Input audio transcription configuration, or `nil` if not set.
    @objc public var inputAudioTranscription: AudioTranscriptionConfig? { _inputAudioTranscription }

    /// Output audio transcription configuration, or `nil` if not set.
    @objc public var outputAudioTranscription: AudioTranscriptionConfig? { _outputAudioTranscription }

    /// Context window compression configuration, or `nil` if not set.
    @objc public var contextWindowCompression: ContextWindowCompressionConfig? {
        _contextWindowCompression
    }
}
