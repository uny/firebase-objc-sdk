import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFileDataPart)
public final class FileDataPart: NSObject {
    let value: FirebaseAILogic.FileDataPart

    init(value: FirebaseAILogic.FileDataPart) {
        self.value = value
        super.init()
    }

    @objc public convenience init(uri: String, mimeType: String) {
        self.init(value: FirebaseAILogic.FileDataPart(uri: uri, mimeType: mimeType))
    }

    @objc public var uri: String {
        value.uri
    }

    @objc public var mimeType: String {
        value.mimeType
    }

    @objc public var isThought: Bool {
        value.isThought
    }
}
