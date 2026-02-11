import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBURLContextMetadata)
public final class URLContextMetadata: NSObject {
    let value: FirebaseAILogic.URLContextMetadata

    init(value: FirebaseAILogic.URLContextMetadata) {
        self.value = value
        super.init()
    }

    @objc public var urlMetadata: [URLMetadata] {
        value.urlMetadata.map { URLMetadata(value: $0) }
    }
}
