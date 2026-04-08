import FirebaseAILogic
import Foundation

/// A template Imagen model for testing.
///
/// > Warning: All Imagen models are deprecated and will shut down as early as June 2026.
/// > As a replacement, migrate your apps to use Gemini Image models (the "Nano Banana" models).
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(
    *,
    deprecated,
    message: "All Imagen models are deprecated and will shut down as early as June 2026. As a replacement, you can migrate your apps to use Gemini Image models (the \"Nano Banana\" models)."
)
@objc(KFBTemplateImagenModel)
public final class TemplateImagenModel: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.TemplateImagenModel

    init(value: FirebaseAILogic.TemplateImagenModel) {
        self.value = value
        super.init()
    }

    /// Generates images from a template with the given inputs.
    @objc public func generateImages(
        templateID: String,
        inputs: [String: Any],
        options: RequestOptions?
    ) async throws -> ImagenGenerationResponse {
        let response = try await value.generateImages(
            templateID: templateID,
            inputs: inputs,
            options: options?.value ?? FirebaseAILogic.RequestOptions()
        )
        return ImagenGenerationResponse(value: response)
    }
}
