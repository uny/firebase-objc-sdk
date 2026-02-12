import FirebaseAILogic
import Foundation

/// A model for generating images using Imagen.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
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
