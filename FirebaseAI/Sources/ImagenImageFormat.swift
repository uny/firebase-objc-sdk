import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenImageFormat)
public final class ImagenImageFormat: NSObject {
    let value: FirebaseAILogic.ImagenImageFormat

    init(value: FirebaseAILogic.ImagenImageFormat) {
        self.value = value
        super.init()
    }

    @objc public static func png() -> ImagenImageFormat {
        return ImagenImageFormat(value: FirebaseAILogic.ImagenImageFormat.png())
    }

    @objc public static func jpeg(compressionQuality: NSNumber?) -> ImagenImageFormat {
        return ImagenImageFormat(value: FirebaseAILogic.ImagenImageFormat.jpeg(
            compressionQuality: compressionQuality?.intValue
        ))
    }
}
