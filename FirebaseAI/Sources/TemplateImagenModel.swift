import FirebaseAILogic
import Foundation

/// A template Imagen model for testing.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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
