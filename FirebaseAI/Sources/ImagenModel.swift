import FirebaseAILogic
import Foundation

/// A model for generating images using Imagen.
///
/// > Warning: All Imagen models are deprecated and will shut down as early as June 2026.
/// > As a replacement, migrate your apps to use Gemini Image models (the "Nano Banana" models).
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(
    *,
    deprecated,
    message: "All Imagen models are deprecated and will shut down as early as June 2026. As a replacement, you can migrate your apps to use Gemini Image models (the \"Nano Banana\" models)."
)
@objc(KFBImagenModel)
public final class ImagenModel: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImagenModel

    init(value: FirebaseAILogic.ImagenModel) {
        self.value = value
        super.init()
    }

    /// Generates images from the given text prompt.
    @objc public func generateImages(prompt: String) async throws -> ImagenGenerationResponse {
        let response = try await value.generateImages(prompt: prompt)
        return ImagenGenerationResponse(value: response)
    }
}
