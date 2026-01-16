import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBUsageMetadata)
public final class UsageMetadata: NSObject {
    let value: FirebaseAILogic.GenerateContentResponse.UsageMetadata

    init(value: FirebaseAILogic.GenerateContentResponse.UsageMetadata) {
        self.value = value
        super.init()
    }

    @objc public var promptTokenCount: Int {
        value.promptTokenCount
    }

    @objc public var candidatesTokenCount: Int {
        value.candidatesTokenCount
    }

    @objc public var toolUsePromptTokenCount: Int {
        value.toolUsePromptTokenCount
    }

    @objc public var thoughtsTokenCount: Int {
        value.thoughtsTokenCount
    }

    @objc public var totalTokenCount: Int {
        value.totalTokenCount
    }
}
