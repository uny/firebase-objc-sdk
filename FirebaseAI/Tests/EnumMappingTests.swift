import XCTest
@testable import FirebaseAILogicObjC

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
final class EnumMappingTests: XCTestCase {

    // MARK: - HarmCategory

    func testHarmCategoryRawValues() {
        XCTAssertEqual(HarmCategory.harassment.rawValue, "HARM_CATEGORY_HARASSMENT")
        XCTAssertEqual(HarmCategory.hateSpeech.rawValue, "HARM_CATEGORY_HATE_SPEECH")
        XCTAssertEqual(HarmCategory.sexuallyExplicit.rawValue, "HARM_CATEGORY_SEXUALLY_EXPLICIT")
        XCTAssertEqual(HarmCategory.dangerousContent.rawValue, "HARM_CATEGORY_DANGEROUS_CONTENT")
        XCTAssertEqual(HarmCategory.civicIntegrity.rawValue, "HARM_CATEGORY_CIVIC_INTEGRITY")
    }

    // MARK: - FinishReason

    func testFinishReasonRawValues() {
        XCTAssertEqual(FinishReason.stop.rawValue, "STOP")
        XCTAssertEqual(FinishReason.maxTokens.rawValue, "MAX_TOKENS")
        XCTAssertEqual(FinishReason.safety.rawValue, "SAFETY")
        XCTAssertEqual(FinishReason.recitation.rawValue, "RECITATION")
        XCTAssertEqual(FinishReason.other.rawValue, "OTHER")
        XCTAssertEqual(FinishReason.blocklist.rawValue, "BLOCKLIST")
        XCTAssertEqual(FinishReason.prohibitedContent.rawValue, "PROHIBITED_CONTENT")
        XCTAssertEqual(FinishReason.spii.rawValue, "SPII")
        XCTAssertEqual(FinishReason.malformedFunctionCall.rawValue, "MALFORMED_FUNCTION_CALL")
    }

    // MARK: - BlockReason

    func testBlockReasonRawValues() {
        XCTAssertEqual(BlockReason.safety.rawValue, "SAFETY")
        XCTAssertEqual(BlockReason.other.rawValue, "OTHER")
        XCTAssertEqual(BlockReason.blocklist.rawValue, "BLOCKLIST")
        XCTAssertEqual(BlockReason.prohibitedContent.rawValue, "PROHIBITED_CONTENT")
    }

    // MARK: - ContentModality

    func testContentModalityRawValues() {
        XCTAssertEqual(ContentModality.text.rawValue, "TEXT")
        XCTAssertEqual(ContentModality.image.rawValue, "IMAGE")
        XCTAssertEqual(ContentModality.video.rawValue, "VIDEO")
        XCTAssertEqual(ContentModality.audio.rawValue, "AUDIO")
        XCTAssertEqual(ContentModality.document.rawValue, "DOCUMENT")
    }

    // MARK: - Distinct Instances

    func testEnumStaticPropertiesReturnDistinctInstances() {
        let first = HarmCategory.harassment
        let second = HarmCategory.harassment
        // Each call returns a new wrapper instance
        XCTAssertFalse(first === second)
        // But they should have the same rawValue
        XCTAssertEqual(first.rawValue, second.rawValue)
    }
}
