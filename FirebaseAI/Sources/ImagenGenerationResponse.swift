import FirebaseAILogic
import Foundation

/// The response from an Imagen image generation request.
///
/// > Warning: All Imagen models are deprecated and will shut down as early as June 2026.
/// > As a replacement, migrate your apps to use Gemini Image models (the "Nano Banana" models).
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(
    *,
    deprecated,
    message: "All Imagen models are deprecated and will shut down as early as June 2026. As a replacement, you can migrate your apps to use Gemini Image models (the \"Nano Banana\" models)."
)
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
