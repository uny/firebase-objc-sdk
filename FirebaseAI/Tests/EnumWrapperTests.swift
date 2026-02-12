import XCTest
@testable import FirebaseAILogicObjC

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
final class EnumWrapperTests: XCTestCase {
    // MARK: - rawValue-based types

    func testHarmCategoryEquality() {
        let first = HarmCategory.harassment
        let second = HarmCategory.harassment
        let other = HarmCategory.hateSpeech
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    func testFinishReasonEquality() {
        let first = FinishReason.stop
        let second = FinishReason.stop
        let other = FinishReason.safety
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    func testBlockReasonEquality() {
        let first = BlockReason.safety
        let second = BlockReason.safety
        let other = BlockReason.other
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    func testHarmProbabilityEquality() {
        let first = HarmProbability.high
        let second = HarmProbability.high
        let other = HarmProbability.low
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    func testHarmSeverityEquality() {
        let first = HarmSeverity.high
        let second = HarmSeverity.high
        let other = HarmSeverity.negligible
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    func testContentModalityEquality() {
        let first = ContentModality.text
        let second = ContentModality.text
        let other = ContentModality.image
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    // MARK: - String(describing:)-based types

    func testHarmBlockThresholdEquality() {
        let first = HarmBlockThreshold.blockNone
        let second = HarmBlockThreshold.blockNone
        let other = HarmBlockThreshold.blockOnlyHigh
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    func testHarmBlockMethodEquality() {
        let first = HarmBlockMethod.severity
        let second = HarmBlockMethod.severity
        let other = HarmBlockMethod.probability
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    func testResponseModalityEquality() {
        let first = ResponseModality.text
        let second = ResponseModality.text
        let other = ResponseModality.image
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    func testImagenSafetyFilterLevelEquality() {
        let first = ImagenSafetyFilterLevel.blockNone
        let second = ImagenSafetyFilterLevel.blockNone
        let other = ImagenSafetyFilterLevel.blockOnlyHigh
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    func testImagenPersonFilterLevelEquality() {
        let first = ImagenPersonFilterLevel.blockAll
        let second = ImagenPersonFilterLevel.blockAll
        let other = ImagenPersonFilterLevel.allowAll
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    func testImagenAspectRatioEquality() {
        let first = ImagenAspectRatio.square1x1
        let second = ImagenAspectRatio.square1x1
        let other = ImagenAspectRatio.landscape16x9
        XCTAssertTrue(first.isEqual(second))
        XCTAssertFalse(first.isEqual(other))
        XCTAssertEqual(first.hash, second.hash)
    }

    // MARK: - Cross-type comparison returns false

    func testCrossTypeComparisonReturnsFalse() {
        let harmCategory = HarmCategory.harassment
        let finishReason = FinishReason.stop
        XCTAssertFalse(harmCategory.isEqual(finishReason))
    }

    func testNilComparisonReturnsFalse() {
        let harmCategory = HarmCategory.harassment
        XCTAssertFalse(harmCategory.isEqual(nil))
    }
}
