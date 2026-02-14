import FirebaseAILogic
import Foundation

/// Token usage metadata for a generation request.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBUsageMetadata)
public final class UsageMetadata: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.GenerateContentResponse.UsageMetadata

    init(value: FirebaseAILogic.GenerateContentResponse.UsageMetadata) {
        self.value = value
        super.init()
    }

    /// The number of tokens in the prompt.
    @objc public var promptTokenCount: Int {
        value.promptTokenCount
    }

    /// The number of tokens in the generated candidates.
    @objc public var candidatesTokenCount: Int {
        value.candidatesTokenCount
    }

    /// The number of tokens used for tool-use prompts.
    @objc public var toolUsePromptTokenCount: Int {
        value.toolUsePromptTokenCount
    }

    /// The number of tokens used for model thinking.
    @objc public var thoughtsTokenCount: Int {
        value.thoughtsTokenCount
    }

    /// The total number of tokens across prompt and candidates.
    @objc public var totalTokenCount: Int {
        value.totalTokenCount
    }

    /// Token count details for the prompt, broken down by modality.
    @objc public var promptTokensDetails: [ModalityTokenCount] {
        value.promptTokensDetails.map { ModalityTokenCount(value: $0) }
    }

    /// Token count details for the candidates, broken down by modality.
    @objc public var candidatesTokensDetails: [ModalityTokenCount] {
        value.candidatesTokensDetails.map { ModalityTokenCount(value: $0) }
    }

    /// Token count details for tool-use prompts, broken down by modality.
    @objc public var toolUsePromptTokensDetails: [ModalityTokenCount] {
        value.toolUsePromptTokensDetails.map { ModalityTokenCount(value: $0) }
    }

    /// The number of tokens in the cached content.
    @objc public var cachedContentTokenCount: Int {
        value.cachedContentTokenCount
    }

    /// Token count details for cached content, broken down by modality.
    @objc public var cacheTokensDetails: [ModalityTokenCount] {
        value.cacheTokensDetails.map { ModalityTokenCount(value: $0) }
    }
}
