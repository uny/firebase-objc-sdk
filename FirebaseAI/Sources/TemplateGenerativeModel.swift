import FirebaseAILogic
import Foundation

/// A template generative model for testing.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBTemplateGenerativeModel)
public final class TemplateGenerativeModel: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.TemplateGenerativeModel

    init(value: FirebaseAILogic.TemplateGenerativeModel) {
        self.value = value
        super.init()
    }

    /// Generates content from a template with the given inputs.
    @objc public func generateContent(
        templateID: String,
        inputs: [String: Any],
        options: RequestOptions?
    ) async throws -> GenerateContentResponse {
        try await mapFirebaseAIErrors {
            GenerateContentResponse(value: try await value.generateContent(
                templateID: templateID,
                inputs: inputs,
                options: options?.value ?? FirebaseAILogic.RequestOptions()
            ))
        }
    }

    /// Returns a stream that generates content from a template.
    @objc public func generateContentStream(
        templateID: String,
        inputs: [String: Any],
        options: RequestOptions?
    ) throws -> ContentStream {
        try mapFirebaseAIErrors {
            ContentStream(stream: try value.generateContentStream(
                templateID: templateID,
                inputs: inputs,
                options: options?.value ?? FirebaseAILogic.RequestOptions()
            ))
        }
    }
}
