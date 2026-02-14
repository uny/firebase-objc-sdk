import FirebaseAILogic
import FirebaseCore
import Foundation

/// Entry point for the Firebase AI SDK ObjC wrapper.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFirebaseAI)
public final class FirebaseAI: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.FirebaseAI

    init(value: FirebaseAILogic.FirebaseAI) {
        self.value = value
        super.init()
    }

    /// Returns a ``FirebaseAI`` instance for the given app and backend.
    ///
    /// - Parameters:
    ///   - app: The Firebase app to use, or `nil` for the default app.
    ///   - backend: The backend AI provider (Google AI or Vertex AI).
    ///   - useLimitedUseAppCheckTokens: Whether to use limited-use App Check tokens for requests.
    @objc public static func firebaseAI(
        app: FirebaseCore.FirebaseApp?,
        backend: Backend,
        useLimitedUseAppCheckTokens: Bool
    ) -> FirebaseAI {
        let firebaseAIInstance = FirebaseAILogic.FirebaseAI.firebaseAI(
            app: app,
            backend: backend.value,
            useLimitedUseAppCheckTokens: useLimitedUseAppCheckTokens
        )
        return FirebaseAI(value: firebaseAIInstance)
    }

    // MARK: - Generative Model

    /// Creates a generative model with the given configuration.
    ///
    /// - Parameters:
    ///   - modelName: The name of the model to use (e.g., `"gemini-2.0-flash"`).
    ///   - generationConfig: Configuration for content generation, or `nil` for defaults.
    ///   - safetySettings: Safety settings to apply, or `nil` for defaults.
    ///   - tools: Tools the model may use to generate responses, or `nil`.
    ///   - toolConfig: Configuration for tool usage, or `nil`.
    ///   - systemInstruction: System instruction content to guide the model, or `nil`.
    ///   - requestOptions: Options for the underlying network request, or `nil`.
    @objc public func generativeModel(
        modelName: String,
        generationConfig: GenerationConfig?,
        safetySettings: [SafetySetting]?,
        tools: [Tool]?,
        toolConfig: ToolConfig?,
        systemInstruction: ModelContent?,
        requestOptions: RequestOptions?
    ) -> GenerativeModel {
        let model = value.generativeModel(
            modelName: modelName,
            generationConfig: generationConfig?.value,
            safetySettings: safetySettings?.map { $0.value },
            tools: tools?.map { $0.value },
            toolConfig: toolConfig?.value,
            systemInstruction: systemInstruction?.value,
            requestOptions: requestOptions?.value ?? FirebaseAILogic.RequestOptions()
        )
        return GenerativeModel(value: model)
    }

    // MARK: - Imagen Model

    /// Creates an Imagen model with the given configuration.
    ///
    /// - Parameters:
    ///   - modelName: The name of the Imagen model to use.
    ///   - generationConfig: Configuration for image generation, or `nil` for defaults.
    ///   - safetySettings: Imagen-specific safety settings, or `nil` for defaults.
    ///   - requestOptions: Options for the underlying network request, or `nil`.
    @objc public func imagenModel(
        modelName: String,
        generationConfig: ImagenGenerationConfig?,
        safetySettings: ImagenSafetySettings?,
        requestOptions: RequestOptions?
    ) -> ImagenModel {
        let model = value.imagenModel(
            modelName: modelName,
            generationConfig: generationConfig?.value,
            safetySettings: safetySettings?.value,
            requestOptions: requestOptions?.value ?? FirebaseAILogic.RequestOptions()
        )
        return ImagenModel(value: model)
    }

    // MARK: - Template Models

    /// Creates a template generative model for unit testing.
    @objc public func templateGenerativeModel() -> TemplateGenerativeModel {
        let model = value.templateGenerativeModel()
        return TemplateGenerativeModel(value: model)
    }

    /// Creates a template Imagen model for unit testing.
    @objc public func templateImagenModel() -> TemplateImagenModel {
        let model = value.templateImagenModel()
        return TemplateImagenModel(value: model)
    }

    // MARK: - Live Model

    /// Creates a live model for bidirectional streaming.
    ///
    /// - Parameters:
    ///   - modelName: The name of the model to use.
    ///   - generationConfig: Configuration for live generation, or `nil` for defaults.
    ///   - tools: Tools the model may use to generate responses, or `nil`.
    ///   - toolConfig: Configuration for tool usage, or `nil`.
    ///   - systemInstruction: System instruction content to guide the model, or `nil`.
    ///   - requestOptions: Options for the underlying network request, or `nil`.
    @available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
    @available(watchOS, unavailable)
    @objc public func liveModel(
        modelName: String,
        generationConfig: LiveGenerationConfig?,
        tools: [Tool]?,
        toolConfig: ToolConfig?,
        systemInstruction: ModelContent?,
        requestOptions: RequestOptions?
    ) -> LiveGenerativeModel {
        let model = value.liveModel(
            modelName: modelName,
            generationConfig: generationConfig?.value,
            tools: tools?.map { $0.value },
            toolConfig: toolConfig?.value,
            systemInstruction: systemInstruction?.value,
            requestOptions: requestOptions?.value ?? FirebaseAILogic.RequestOptions()
        )
        return LiveGenerativeModel(value: model)
    }
}
