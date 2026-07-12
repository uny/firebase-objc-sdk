#if compiler(>=6.2.3)
import FirebaseAILogic
import Foundation

/// A model provider that combines a primary (on-device) model and a secondary (cloud) fallback
/// model for use with ``GenerativeModelSession``.
///
/// **Experimental**: This wraps Firebase's [Hybrid Inference
/// ](https://firebase.google.com/docs/ai-logic/hybrid/ios/get-started) feature
/// (`LanguageModelProvider.hybridModel(primary:secondary:)` / `HybridModel`), which is
/// experimental: it has no SLA, its API may change or be removed without notice, and it
/// currently supports text generation only (no multimodal input), a maximum of 4096 tokens,
/// and requires the app to be in the foreground. On-device inference additionally requires an
/// Apple Intelligence-eligible device; on unsupported devices Firebase automatically falls back
/// to the secondary (cloud) model.
///
/// Pass the resulting ``HybridModel`` to
/// ``FirebaseAI/generativeModelSession(hybridModel:instructions:)`` to start a session backed by
/// the hybrid model.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHybridModel)
public final class HybridModel: NSObject, @unchecked Sendable {
    let value: any FirebaseAILogic.LanguageModelProvider

    private init(value: any FirebaseAILogic.LanguageModelProvider) {
        self.value = value
        super.init()
    }

    /// Creates a ``HybridModel`` that uses an on-device model as the primary model, falling back
    /// to a cloud Gemini model named `secondaryModelName` when the on-device model is
    /// unavailable.
    ///
    /// - Parameters:
    ///   - primary: The on-device model to use as the primary model; defaults to
    ///     ``SystemLanguageModel/systemDefault``.
    ///   - secondaryModelName: The name of the cloud Gemini model to fall back to (e.g.
    ///     `"gemini-2.0-flash"`); see [available model names
    ///     ](https://firebase.google.com/docs/vertex-ai/gemini-models#available-model-names).
    @objc public static func hybridModel(
        primary: SystemLanguageModel?,
        secondaryModelName: String
    ) -> HybridModel {
        // `FirebaseAILogic.FirebaseAI.SystemLanguageModel` conforms to `LanguageModel`, which in
        // turn conforms to `LanguageModelProvider` via its default `_languageModel(firebaseAI:)`
        // implementation, so it can be passed directly as the `primary` provider.
        let provider = FirebaseAILogic.HybridModelProvider.hybridModel(
            primary: (primary ?? .systemDefault).value,
            secondary: secondaryModelName
        )
        return HybridModel(value: provider)
    }
}
#endif // compiler(>=6.2.3)
