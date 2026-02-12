import FirebaseAILogic
import Foundation

/// Metadata containing citations for generated content.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCitationMetadata)
public final class CitationMetadata: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.CitationMetadata

    init(value: FirebaseAILogic.CitationMetadata) {
        self.value = value
        super.init()
    }

    /// The list of citations for the generated content.
    @objc public var citations: [Citation] {
        value.citations.map { Citation(value: $0) }
    }
}
