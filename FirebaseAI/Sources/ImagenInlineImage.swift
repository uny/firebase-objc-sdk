import FirebaseAILogic
import Foundation

/// An inline image returned by Imagen.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenInlineImage)
public final class ImagenInlineImage: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImagenInlineImage

    init(value: FirebaseAILogic.ImagenInlineImage) {
        self.value = value
        super.init()
    }

    /// The MIME type of the image (e.g., `"image/png"`).
    @objc public var mimeType: String {
        return value.mimeType
    }

    /// The raw image data.
    @objc public var data: Data {
        return value.data
    }
}
