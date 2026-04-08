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

    // MARK: - Distinct Instances

    @Test func enumStaticPropertiesReturnDistinctInstances() {
        let first = HarmCategory.harassment
        let second = HarmCategory.harassment
        #expect(first !== second)
        #expect(first.rawValue == second.rawValue)
    }
}
