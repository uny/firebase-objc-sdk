import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCitationMetadata)
public final class CitationMetadata: NSObject {
    let value: FirebaseAILogic.CitationMetadata

    init(value: FirebaseAILogic.CitationMetadata) {
        self.value = value
        super.init()
    }

    @objc public var citations: [Citation] {
        value.citations.map { Citation(value: $0) }
    }
}
