#if compiler(>=6.2.3)
import Foundation
import Testing
@testable import FirebaseAILogicObjC

@Suite struct HybridModelTests {
    // MARK: - SystemLanguageModelUseCase

    @Test func systemLanguageModelUseCaseEquality() {
        let first = SystemLanguageModelUseCase.general
        let second = SystemLanguageModelUseCase.general
        let other = SystemLanguageModelUseCase.contentTagging
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    // MARK: - SystemLanguageModelGuardrails

    @Test func systemLanguageModelGuardrailsEquality() {
        let first = SystemLanguageModelGuardrails.default
        let second = SystemLanguageModelGuardrails.default
        let other = SystemLanguageModelGuardrails.permissiveContentTransformations
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    // MARK: - SystemLanguageModel

    @Test func systemLanguageModelDefaultDoesNotCrash() {
        let model = SystemLanguageModel.systemDefault
        // The test environment is not guaranteed to be Apple Intelligence-eligible, so only
        // assert internal consistency between `isAvailable` and `availability`.
        #expect(model.isAvailable == model.availability.isAvailable)
    }

    @Test func systemLanguageModelCustomInitDoesNotCrash() {
        let model = SystemLanguageModel(
            useCase: .contentTagging,
            guardrails: .permissiveContentTransformations
        )
        #expect(model.isAvailable == model.availability.isAvailable)
    }

    @Test func systemLanguageModelDefaultParametersMatchExplicitDefaults() {
        let implicit = SystemLanguageModel(useCase: nil, guardrails: nil)
        let explicit = SystemLanguageModel(useCase: .general, guardrails: .default)
        #expect(implicit.isAvailable == explicit.isAvailable)
    }

    // MARK: - HybridModel

    @Test func hybridModelWithDefaultPrimaryDoesNotCrash() {
        let hybridModel = HybridModel.hybridModel(
            primary: nil,
            secondaryModelName: "gemini-2.0-flash"
        )
        #expect(hybridModel.isKind(of: HybridModel.self))
    }

    @Test func hybridModelWithExplicitPrimaryDoesNotCrash() {
        let onDeviceModel = SystemLanguageModel(useCase: .general, guardrails: .default)
        let hybridModel = HybridModel.hybridModel(
            primary: onDeviceModel,
            secondaryModelName: "gemini-2.0-flash"
        )
        #expect(hybridModel.isKind(of: HybridModel.self))
    }
}
#endif
