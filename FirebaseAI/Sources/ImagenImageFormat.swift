import FirebaseAILogic
import Foundation

/// The output format for Imagen-generated images.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenImageFormat)
public final class ImagenImageFormat: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImagenImageFormat

    init(value: FirebaseAILogic.ImagenImageFormat) {
        self.value = value
        super.init()
    }

    /// Creates a PNG image format.
    @objc public static func png() -> ImagenImageFormat {
        return ImagenImageFormat(value: FirebaseAILogic.ImagenImageFormat.png())
    }

    /// Creates a JPEG image format with an optional compression quality.
    @objc public static func jpeg(compressionQuality: NSNumber?) -> ImagenImageFormat {
        return ImagenImageFormat(value: FirebaseAILogic.ImagenImageFormat.jpeg(
            compressionQuality: compressionQuality?.intValue
        ))
    }
}
