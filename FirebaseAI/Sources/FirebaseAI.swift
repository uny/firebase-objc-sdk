import FirebaseAILogic
import FirebaseCore
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFirebaseAI)
public final class FirebaseAI: NSObject {
    let value: FirebaseAILogic.FirebaseAI

    init(value: FirebaseAILogic.FirebaseAI) {
        self.value = value
        super.init()
    }

    @objc public static func firebaseAI(
        app: FirebaseCore.FirebaseApp?,
        backend: Backend,
        useLimitedUseAppCheckTokens: Bool
    ) -> FirebaseAI {
        let ai = FirebaseAILogic.FirebaseAI.firebaseAI(
            app: app,
            backend: backend.value,
            useLimitedUseAppCheckTokens: useLimitedUseAppCheckTokens
        )
        return FirebaseAI(value: ai)
    }

    // MARK: - Generative Model

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

    @objc public func templateGenerativeModel() -> TemplateGenerativeModel {
        let model = value.templateGenerativeModel()
        return TemplateGenerativeModel(value: model)
    }

    @objc public func templateImagenModel() -> TemplateImagenModel {
        let model = value.templateImagenModel()
        return TemplateImagenModel(value: model)
    }

    // MARK: - Live Model

    @available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
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
