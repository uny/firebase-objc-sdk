import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCitation)
public final class Citation: NSObject {
    let value: FirebaseAILogic.Citation

    init(value: FirebaseAILogic.Citation) {
        self.value = value
        super.init()
    }

    @objc public var startIndex: Int {
        value.startIndex
    }

    @objc public var endIndex: Int {
        value.endIndex
    }

    @objc public var uri: String? {
        value.uri
    }

    @objc public var title: String? {
        value.title
    }

    @objc public var license: String? {
        value.license
    }

    /// The publication date as DateComponents. May be nil if not available.
    @objc public var publicationDate: DateComponents? {
        value.publicationDate
    }
}
