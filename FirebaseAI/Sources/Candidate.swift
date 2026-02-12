import FirebaseAILogic
import Foundation

/// A single response candidate from the model.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCandidate)
public final class Candidate: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.Candidate

    init(value: FirebaseAILogic.Candidate) {
        self.value = value
        super.init()
    }

    /// The generated content for this candidate.
    @objc public var content: ModelContent {
        ModelContent(value: value.content)
    }

    /// The safety ratings for this candidate's content.
    @objc public var safetyRatings: [SafetyRating] {
        value.safetyRatings.map { SafetyRating(value: $0) }
    }

    /// The reason the model stopped generating content, or `nil` if still in progress.
    @objc public var finishReason: FinishReason? {
        value.finishReason.map { FinishReason(value: $0) }
    }

    /// Metadata about citations in the generated content, or `nil` if none.
    @objc public var citationMetadata: CitationMetadata? {
        value.citationMetadata.map { CitationMetadata(value: $0) }
    }

    /// Metadata about grounding used to generate this candidate, or `nil` if none.
    @objc public var groundingMetadata: GroundingMetadata? {
        value.groundingMetadata.map { GroundingMetadata(value: $0) }
    }

    /// Metadata about URL context used to generate this candidate, or `nil` if none.
    @objc public var urlContextMetadata: URLContextMetadata? {
        value.urlContextMetadata.map { URLContextMetadata(value: $0) }
    }
}
