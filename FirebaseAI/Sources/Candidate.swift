import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCandidate)
public final class Candidate: NSObject {
    let value: FirebaseAILogic.Candidate

    init(value: FirebaseAILogic.Candidate) {
        self.value = value
        super.init()
    }

    @objc public var content: ModelContent {
        ModelContent(value: value.content)
    }

    @objc public var safetyRatings: [SafetyRating] {
        value.safetyRatings.map { SafetyRating(value: $0) }
    }

    @objc public var finishReason: FinishReason? {
        value.finishReason.map { FinishReason(value: $0) }
    }

    @objc public var citationMetadata: CitationMetadata? {
        value.citationMetadata.map { CitationMetadata(value: $0) }
    }
}
