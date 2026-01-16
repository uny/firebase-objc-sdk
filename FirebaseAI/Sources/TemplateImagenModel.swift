import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBTemplateImagenModel)
public final class TemplateImagenModel: NSObject {
    let value: FirebaseAILogic.TemplateImagenModel

    init(value: FirebaseAILogic.TemplateImagenModel) {
        self.value = value
        super.init()
    }

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
