import FirebaseAILogic
import Foundation

/// The response from an Imagen image generation request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenGenerationResponse)
public final class ImagenGenerationResponse: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImagenGenerationResponse<FirebaseAILogic.ImagenInlineImage>

    init(value: FirebaseAILogic.ImagenGenerationResponse<FirebaseAILogic.ImagenInlineImage>) {
        self.value = value
        super.init()
    }

    /// The generated images.
    @objc public var images: [ImagenInlineImage] {
        return value.images.map { ImagenInlineImage(value: $0) }
    }

    /// The reason the images were filtered, if applicable.
    @objc public var filteredReason: String? {
        return value.filteredReason
    }
}
