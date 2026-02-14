import FirebaseAILogic
import Foundation

/// A citation source for generated content.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCitation)
public final class Citation: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.Citation

    init(value: FirebaseAILogic.Citation) {
        self.value = value
        super.init()
    }

    /// The start index of the cited passage in the generated text.
    @objc public var startIndex: Int {
        value.startIndex
    }

    /// The end index of the cited passage in the generated text.
    @objc public var endIndex: Int {
        value.endIndex
    }

    /// The URI of the cited source.
    @objc public var uri: String? {
        value.uri
    }

    /// The title of the cited source.
    @objc public var title: String? {
        value.title
    }

    /// The license of the cited source.
    @objc public var license: String? {
        value.license
    }

    /// The publication date as DateComponents. May be nil if not available.
    @objc public var publicationDate: DateComponents? {
        value.publicationDate
    }
}
