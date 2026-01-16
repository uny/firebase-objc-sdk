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

    /// Creates a GenerativeModel with the specified configuration.
    @objc public func generativeModel(
        modelName: String,
        generationConfig: GenerationConfig?,
        safetySettings: [SafetySetting]?
    ) -> GenerativeModel {
        let model = value.generativeModel(
            modelName: modelName,
            generationConfig: generationConfig?.value,
            safetySettings: safetySettings?.map { $0.value }
        )
        return GenerativeModel(value: model)
    }

    /// Creates a GenerativeModel with just the model name.
    @objc public func generativeModel(modelName: String) -> GenerativeModel {
        let model = value.generativeModel(modelName: modelName)
        return GenerativeModel(value: model)
    }

    /// Creates a GenerativeModel with model name and generation config.
    @objc public func generativeModel(
        modelName: String,
        generationConfig: GenerationConfig?
    ) -> GenerativeModel {
        let model = value.generativeModel(
            modelName: modelName,
            generationConfig: generationConfig?.value
        )
        return GenerativeModel(value: model)
    }
}
