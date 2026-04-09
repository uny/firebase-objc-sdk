import Foundation
import Testing
@testable import FirebaseAILogicObjC

@Suite struct EnumMappingTests {

    // MARK: - HarmCategory

    @Test func harmCategoryRawValues() {
        #expect(HarmCategory.harassment.rawValue == "HARM_CATEGORY_HARASSMENT")
        #expect(HarmCategory.hateSpeech.rawValue == "HARM_CATEGORY_HATE_SPEECH")
        #expect(HarmCategory.sexuallyExplicit.rawValue == "HARM_CATEGORY_SEXUALLY_EXPLICIT")
        #expect(HarmCategory.dangerousContent.rawValue == "HARM_CATEGORY_DANGEROUS_CONTENT")
        #expect(HarmCategory.civicIntegrity.rawValue == "HARM_CATEGORY_CIVIC_INTEGRITY")
    }

    // MARK: - FinishReason

    @Test func finishReasonRawValues() {
        #expect(FinishReason.stop.rawValue == "STOP")
        #expect(FinishReason.maxTokens.rawValue == "MAX_TOKENS")
        #expect(FinishReason.safety.rawValue == "SAFETY")
        #expect(FinishReason.recitation.rawValue == "RECITATION")
        #expect(FinishReason.other.rawValue == "OTHER")
        #expect(FinishReason.blocklist.rawValue == "BLOCKLIST")
        #expect(FinishReason.prohibitedContent.rawValue == "PROHIBITED_CONTENT")
        #expect(FinishReason.spii.rawValue == "SPII")
        #expect(FinishReason.malformedFunctionCall.rawValue == "MALFORMED_FUNCTION_CALL")
    }

    // MARK: - BlockReason

    @Test func blockReasonRawValues() {
        #expect(BlockReason.safety.rawValue == "SAFETY")
        #expect(BlockReason.other.rawValue == "OTHER")
        #expect(BlockReason.blocklist.rawValue == "BLOCKLIST")
        #expect(BlockReason.prohibitedContent.rawValue == "PROHIBITED_CONTENT")
    }

    // MARK: - ContentModality

    @Test func contentModalityRawValues() {
        #expect(ContentModality.text.rawValue == "TEXT")
        #expect(ContentModality.image.rawValue == "IMAGE")
        #expect(ContentModality.video.rawValue == "VIDEO")
        #expect(ContentModality.audio.rawValue == "AUDIO")
        #expect(ContentModality.document.rawValue == "DOCUMENT")
    }

    // MARK: - ExecutableCodeLanguage

    @Test func executableCodeLanguageRawValues() {
        #expect(ExecutableCodeLanguage.python.rawValue == "PYTHON")
    }

    // MARK: - CodeExecutionOutcome

    @Test func codeExecutionOutcomeRawValues() {
        #expect(CodeExecutionOutcome.ok.rawValue == "OUTCOME_OK")
        #expect(CodeExecutionOutcome.failed.rawValue == "OUTCOME_FAILED")
        #expect(CodeExecutionOutcome.deadlineExceeded.rawValue == "OUTCOME_DEADLINE_EXCEEDED")
    }

    // MARK: - URLRetrievalStatus

    @Test func urlRetrievalStatusRawValues() {
        #expect(URLRetrievalStatus.success.rawValue == "URL_RETRIEVAL_STATUS_SUCCESS")
        #expect(URLRetrievalStatus.error.rawValue == "URL_RETRIEVAL_STATUS_ERROR")
        #expect(URLRetrievalStatus.paywall.rawValue == "URL_RETRIEVAL_STATUS_PAYWALL")
        #expect(URLRetrievalStatus.unsafe.rawValue == "URL_RETRIEVAL_STATUS_UNSAFE")
    }

    // MARK: - Distinct Instances

    @Test func enumStaticPropertiesReturnDistinctInstances() {
        let first = HarmCategory.harassment
        let second = HarmCategory.harassment
        #expect(first !== second)
        #expect(first.rawValue == second.rawValue)
    }
}
