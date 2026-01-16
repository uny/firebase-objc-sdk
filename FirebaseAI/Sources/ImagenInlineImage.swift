import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenInlineImage)
public final class ImagenInlineImage: NSObject {
    let value: FirebaseAILogic.ImagenInlineImage

    init(value: FirebaseAILogic.ImagenInlineImage) {
        self.value = value
        super.init()
    }

    @objc public var mimeType: String {
        return value.mimeType
    }

    @objc public var data: Data {
        return value.data
    }
}
