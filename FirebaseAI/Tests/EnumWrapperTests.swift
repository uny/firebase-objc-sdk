import XCTest
@testable import FirebaseAILogicObjC

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
final class EnumWrapperTests: XCTestCase {
    // MARK: - rawValue-based types

    func testHarmCategoryEquality() {
        let a = HarmCategory.harassment
        let b = HarmCategory.harassment
        let c = HarmCategory.hateSpeech
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    func testFinishReasonEquality() {
        let a = FinishReason.stop
        let b = FinishReason.stop
        let c = FinishReason.safety
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    func testBlockReasonEquality() {
        let a = BlockReason.safety
        let b = BlockReason.safety
        let c = BlockReason.other
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    func testHarmProbabilityEquality() {
        let a = HarmProbability.high
        let b = HarmProbability.high
        let c = HarmProbability.low
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    func testHarmSeverityEquality() {
        let a = HarmSeverity.high
        let b = HarmSeverity.high
        let c = HarmSeverity.negligible
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    func testContentModalityEquality() {
        let a = ContentModality.text
        let b = ContentModality.text
        let c = ContentModality.image
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    // MARK: - String(describing:)-based types

    func testHarmBlockThresholdEquality() {
        let a = HarmBlockThreshold.blockNone
        let b = HarmBlockThreshold.blockNone
        let c = HarmBlockThreshold.blockOnlyHigh
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    func testHarmBlockMethodEquality() {
        let a = HarmBlockMethod.severity
        let b = HarmBlockMethod.severity
        let c = HarmBlockMethod.probability
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    func testResponseModalityEquality() {
        let a = ResponseModality.text
        let b = ResponseModality.text
        let c = ResponseModality.image
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    func testImagenSafetyFilterLevelEquality() {
        let a = ImagenSafetyFilterLevel.blockNone
        let b = ImagenSafetyFilterLevel.blockNone
        let c = ImagenSafetyFilterLevel.blockOnlyHigh
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    func testImagenPersonFilterLevelEquality() {
        let a = ImagenPersonFilterLevel.blockAll
        let b = ImagenPersonFilterLevel.blockAll
        let c = ImagenPersonFilterLevel.allowAll
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
    }

    func testImagenAspectRatioEquality() {
        let a = ImagenAspectRatio.square1x1
        let b = ImagenAspectRatio.square1x1
        let c = ImagenAspectRatio.landscape16x9
        XCTAssertTrue(a.isEqual(b))
        XCTAssertFalse(a.isEqual(c))
        XCTAssertEqual(a.hash, b.hash)
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
