import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerationConfig)
public final class GenerationConfig: NSObject {
    let value: FirebaseAILogic.GenerationConfig

    init(value: FirebaseAILogic.GenerationConfig) {
        self.value = value
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
            thinkingConfig: thinkingConfig?.value
        )
        self.init(value: config)
    }
}
