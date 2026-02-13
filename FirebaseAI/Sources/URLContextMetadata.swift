import FirebaseAILogic
import Foundation

/// Metadata for URL context used in generation.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBURLContextMetadata)
public final class URLContextMetadata: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.URLContextMetadata

    init(value: FirebaseAILogic.URLContextMetadata) {
        self.value = value
        super.init()
    }

    /// The list of URL metadata entries.
    @objc public var urlMetadata: [URLMetadata] {
        value.urlMetadata.map { URLMetadata(value: $0) }
    }
}
