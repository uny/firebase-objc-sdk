import FirebaseAILogic
import Foundation

/// Configuration for content generation.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerationConfig)
public final class GenerationConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.GenerationConfig

    // Stored copies of init parameters (upstream properties are internal).
    private let _temperature: NSNumber?
    private let _topP: NSNumber?
    private let _topK: NSNumber?
    private let _candidateCount: NSNumber?
    private let _maxOutputTokens: NSNumber?
    private let _presencePenalty: NSNumber?
    private let _frequencyPenalty: NSNumber?
    private let _stopSequences: [String]?
    private let _responseMIMEType: String?
    private let _responseSchema: Schema?
    private let _responseModalities: [ResponseModality]?
    private let _thinkingConfig: ThinkingConfig?
    private let _imageConfig: ImageConfig?

    init(value: FirebaseAILogic.GenerationConfig) {
        self.value = value
        _temperature = nil
        _topP = nil
        _topK = nil
        _candidateCount = nil
        _maxOutputTokens = nil
        _presencePenalty = nil
        _frequencyPenalty = nil
        _stopSequences = nil
        _responseMIMEType = nil
        _responseSchema = nil
        _responseModalities = nil
        _thinkingConfig = nil
        _imageConfig = nil
        super.init()
    }

    /// Creates a GenerationConfig with the specified parameters.
    /// All parameters are optional - pass nil to use default values.
    @objc public convenience init(
        temperature: NSNumber?,
        topP: NSNumber?,
        topK: NSNumber?,
        candidateCount: NSNumber?,
        maxOutputTokens: NSNumber?,
        presencePenalty: NSNumber?,
        frequencyPenalty: NSNumber?,
        stopSequences: [String]?,
        responseMIMEType: String?,
        responseSchema: Schema?,
        responseModalities: [ResponseModality]?,
        thinkingConfig: ThinkingConfig?
    ) {
        self.init(
            temperature: temperature,
            topP: topP,
            topK: topK,
            candidateCount: candidateCount,
            maxOutputTokens: maxOutputTokens,
            presencePenalty: presencePenalty,
            frequencyPenalty: frequencyPenalty,
            stopSequences: stopSequences,
            responseMIMEType: responseMIMEType,
            responseSchema: responseSchema,
            responseModalities: responseModalities,
            thinkingConfig: thinkingConfig,
            imageConfig: nil
        )
    }

    /// Creates a GenerationConfig with the specified parameters.
    /// All parameters are optional - pass nil to use default values.
    @objc public convenience init(
        temperature: NSNumber?,
        topP: NSNumber?,
        topK: NSNumber?,
        candidateCount: NSNumber?,
        maxOutputTokens: NSNumber?,
        presencePenalty: NSNumber?,
        frequencyPenalty: NSNumber?,
        stopSequences: [String]?,
        responseMIMEType: String?,
        responseSchema: Schema?,
        responseModalities: [ResponseModality]?,
        thinkingConfig: ThinkingConfig?,
        imageConfig: ImageConfig?
    ) {
        let config = FirebaseAILogic.GenerationConfig(
            temperature: temperature?.floatValue,
            topP: topP?.floatValue,
            topK: topK?.intValue,
            candidateCount: candidateCount?.intValue,
            maxOutputTokens: maxOutputTokens?.intValue,
            presencePenalty: presencePenalty?.floatValue,
            frequencyPenalty: frequencyPenalty?.floatValue,
            stopSequences: stopSequences,
            responseMIMEType: responseMIMEType,
            responseSchema: responseSchema?.value,
            responseModalities: responseModalities?.map { $0.value },
            thinkingConfig: thinkingConfig?.value,
            imageConfig: imageConfig?.value
        )
        self.init(value: config,
                  temperature: temperature,
                  topP: topP,
                  topK: topK,
                  candidateCount: candidateCount,
                  maxOutputTokens: maxOutputTokens,
                  presencePenalty: presencePenalty,
                  frequencyPenalty: frequencyPenalty,
                  stopSequences: stopSequences,
                  responseMIMEType: responseMIMEType,
                  responseSchema: responseSchema,
                  responseModalities: responseModalities,
                  thinkingConfig: thinkingConfig,
                  imageConfig: imageConfig)
    }

    private init(
        value: FirebaseAILogic.GenerationConfig,
        temperature: NSNumber?,
        topP: NSNumber?,
        topK: NSNumber?,
        candidateCount: NSNumber?,
        maxOutputTokens: NSNumber?,
        presencePenalty: NSNumber?,
        frequencyPenalty: NSNumber?,
        stopSequences: [String]?,
        responseMIMEType: String?,
        responseSchema: Schema?,
        responseModalities: [ResponseModality]?,
        thinkingConfig: ThinkingConfig?,
        imageConfig: ImageConfig?
    ) {
        self.value = value
        _temperature = temperature
        _topP = topP
        _topK = topK
        _candidateCount = candidateCount
        _maxOutputTokens = maxOutputTokens
        _presencePenalty = presencePenalty
        _frequencyPenalty = frequencyPenalty
        _stopSequences = stopSequences
        _responseMIMEType = responseMIMEType
        _responseSchema = responseSchema
        _responseModalities = responseModalities
        _thinkingConfig = thinkingConfig
        _imageConfig = imageConfig
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

    /// A set of up to 5 strings that will stop output generation, or `nil` if not set.
    @objc public var stopSequences: [String]? { _stopSequences }

    /// Output response MIME type of the generated candidate text, or `nil` if not set.
    @objc public var responseMIMEType: String? { _responseMIMEType }

    /// Output schema of the generated candidate text, or `nil` if not set.
    @objc public var responseSchema: Schema? { _responseSchema }

    /// Supported modalities of the response, or `nil` if not set.
    @objc public var responseModalities: [ResponseModality]? { _responseModalities }

    /// Configuration for controlling the "thinking" behavior, or `nil` if not set.
    @objc public var thinkingConfig: ThinkingConfig? { _thinkingConfig }

    /// Configuration for image generation, or `nil` if not set.
    @objc public var imageConfig: ImageConfig? { _imageConfig }
}
