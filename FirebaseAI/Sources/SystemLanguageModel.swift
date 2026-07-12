#if compiler(>=6.2.3)
import FirebaseAILogic
import Foundation

/// The use case that the on-device model is tuned for.
///
/// **Experimental**: Mirrors `FirebaseAI.SystemLanguageModel.UseCase`, part of Firebase's
/// experimental Hybrid Inference feature. This API has no SLA and may change or be removed
/// without notice; see
/// [Hybrid Inference](https://firebase.google.com/docs/ai-logic/hybrid/ios/get-started) docs.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSystemLanguageModelUseCase)
public final class SystemLanguageModelUseCase: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.FirebaseAI.SystemLanguageModel.UseCase

    init(value: FirebaseAILogic.FirebaseAI.SystemLanguageModel.UseCase) {
        self.value = value
        super.init()
    }

    /// The default use case for general model tasks.
    @objc public static var general: SystemLanguageModelUseCase {
        SystemLanguageModelUseCase(value: .general)
    }

    /// A use case for content tagging and categorization tasks.
    @objc public static var contentTagging: SystemLanguageModelUseCase {
        SystemLanguageModelUseCase(value: .contentTagging)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? SystemLanguageModelUseCase else { return false }
        return value == other.value
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}

/// Settings for controlling how potentially harmful content is blocked or flagged by the
/// on-device model.
///
/// **Experimental**: Mirrors `FirebaseAI.SystemLanguageModel.Guardrails`, part of Firebase's
/// experimental Hybrid Inference feature. This API has no SLA and may change or be removed
/// without notice.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSystemLanguageModelGuardrails)
public final class SystemLanguageModelGuardrails: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.FirebaseAI.SystemLanguageModel.Guardrails

    init(value: FirebaseAILogic.FirebaseAI.SystemLanguageModel.Guardrails) {
        self.value = value
        super.init()
    }

    /// The default guardrail settings for the on-device model.
    @objc public static var `default`: SystemLanguageModelGuardrails {
        SystemLanguageModelGuardrails(value: .default)
    }

    /// Guardrail settings that are less restrictive for content transformation prompts.
    @objc public static var permissiveContentTransformations: SystemLanguageModelGuardrails {
        SystemLanguageModelGuardrails(value: .permissiveContentTransformations)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? SystemLanguageModelGuardrails else { return false }
        return value == other.value
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}

/// Reasons that the on-device model is unavailable.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSystemLanguageModelUnavailableReason)
public enum SystemLanguageModelUnavailableReason: Int {
    /// The device does not support the on-device model.
    case deviceNotEligible = 0
    /// The user does not have Apple Intelligence enabled on their device.
    case appleIntelligenceNotEnabled = 1
    /// The on-device model isn't available on the user's device.
    case modelNotReady = 2
    /// The on-device model is unavailable for an unknown reason.
    case unknown = 3
}

/// The availability status for the on-device model.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSystemLanguageModelAvailability)
public final class SystemLanguageModelAvailability: NSObject, @unchecked Sendable {
    /// `true` if the on-device model is ready and available for use.
    @objc public let isAvailable: Bool

    /// The reason the model is unavailable. Only meaningful when ``isAvailable`` is `false`.
    @objc public let unavailableReason: SystemLanguageModelUnavailableReason

    init(isAvailable: Bool, unavailableReason: SystemLanguageModelUnavailableReason) {
        self.isAvailable = isAvailable
        self.unavailableReason = unavailableReason
        super.init()
    }
}

/// An on-device text generation model provided by Apple's Foundation Models framework.
///
/// **Experimental**: This wraps `FirebaseAI.SystemLanguageModel`, part of Firebase's
/// experimental [Hybrid Inference
/// ](https://firebase.google.com/docs/ai-logic/hybrid/ios/get-started) feature. Hybrid Inference
/// has no SLA and its API may change or be removed without notice. On-device generation requires
/// an Apple Intelligence-eligible device; otherwise this model reports itself as unavailable and
/// any attempt to use it as the sole model will fail.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSystemLanguageModel)
public final class SystemLanguageModel: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.FirebaseAI.SystemLanguageModel

    init(value: FirebaseAILogic.FirebaseAI.SystemLanguageModel) {
        self.value = value
        super.init()
    }

    /// Returns the on-device model configured with the default settings.
    @objc public static var systemDefault: SystemLanguageModel {
        SystemLanguageModel(value: .default)
    }

    /// Initializes an on-device text generation model.
    ///
    /// - Parameters:
    ///   - useCase: The use case the model is tuned for; defaults to ``SystemLanguageModelUseCase/general``.
    ///   - guardrails: The guardrail settings for potentially harmful content; defaults to
    ///     ``SystemLanguageModelGuardrails/default``.
    @objc public init(
        useCase: SystemLanguageModelUseCase?,
        guardrails: SystemLanguageModelGuardrails?
    ) {
        self.value = FirebaseAILogic.FirebaseAI.SystemLanguageModel(
            useCase: useCase?.value ?? .general,
            guardrails: guardrails?.value ?? .default
        )
        super.init()
    }

    /// Returns `true` if the on-device model is available for use.
    @objc public var isAvailable: Bool {
        value.isAvailable
    }

    /// The availability status for the on-device model, including the reason it is unavailable
    /// if applicable.
    @objc public var availability: SystemLanguageModelAvailability {
        switch value.availability {
        case .available:
            return SystemLanguageModelAvailability(isAvailable: true, unavailableReason: .unknown)
        case let .unavailable(reason):
            let mapped: SystemLanguageModelUnavailableReason
            switch reason {
            case .deviceNotEligible:
                mapped = .deviceNotEligible
            case .appleIntelligenceNotEnabled:
                mapped = .appleIntelligenceNotEnabled
            case .modelNotReady:
                mapped = .modelNotReady
            case .unknown:
                mapped = .unknown
            @unknown default:
                mapped = .unknown
            }
            return SystemLanguageModelAvailability(isAvailable: false, unavailableReason: mapped)
        }
    }
}
#endif // compiler(>=6.2.3)
