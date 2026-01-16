import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBTemplateGenerativeModel)
public final class TemplateGenerativeModel: NSObject {
    let value: FirebaseAILogic.TemplateGenerativeModel

    init(value: FirebaseAILogic.TemplateGenerativeModel) {
        self.value = value
        super.init()
    }

    @objc public func generateContent(
        templateID: String,
        inputs: [String: Any],
        options: RequestOptions?
    ) async throws -> GenerateContentResponse {
        let response = try await value.generateContent(
            templateID: templateID,
            inputs: inputs,
            options: options?.value ?? FirebaseAILogic.RequestOptions()
        )
        return GenerateContentResponse(value: response)
    }
}
