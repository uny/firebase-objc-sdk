import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerateContentResponse)
public final class GenerateContentResponse: NSObject {
    let value: FirebaseAILogic.GenerateContentResponse

    init(value: FirebaseAILogic.GenerateContentResponse) {
        self.value = value
        super.init()
    }

    @objc public var candidates: [Candidate] {
        value.candidates.map { Candidate(value: $0) }
    }

    @objc public var promptFeedback: PromptFeedback? {
        value.promptFeedback.map { PromptFeedback(value: $0) }
    }

    @objc public var usageMetadata: UsageMetadata? {
        value.usageMetadata.map { UsageMetadata(value: $0) }
    }

    @objc public var text: String? {
        value.text
    }

    @objc public var thoughtSummary: String? {
        value.thoughtSummary
    }

    @objc public var functionCalls: [FunctionCallPart] {
        value.functionCalls.map { FunctionCallPart(value: $0) }
    }

    @objc public var inlineDataParts: [InlineDataPart] {
        value.inlineDataParts.map { InlineDataPart(value: $0) }
    }
}
