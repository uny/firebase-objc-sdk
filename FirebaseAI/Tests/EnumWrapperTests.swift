import Foundation
import Testing
@testable import FirebaseAILogicObjC

@Suite struct EnumWrapperTests {
    // MARK: - rawValue-based types

    @Test func harmCategoryEquality() {
        let first = HarmCategory.harassment
        let second = HarmCategory.harassment
        let other = HarmCategory.hateSpeech
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func finishReasonEquality() {
        let first = FinishReason.stop
        let second = FinishReason.stop
        let other = FinishReason.safety
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func blockReasonEquality() {
        let first = BlockReason.safety
        let second = BlockReason.safety
        let other = BlockReason.other
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func harmProbabilityEquality() {
        let first = HarmProbability.high
        let second = HarmProbability.high
        let other = HarmProbability.low
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func harmSeverityEquality() {
        let first = HarmSeverity.high
        let second = HarmSeverity.high
        let other = HarmSeverity.negligible
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func contentModalityEquality() {
        let first = ContentModality.text
        let second = ContentModality.text
        let other = ContentModality.image
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func thinkingLevelEquality() {
        let first = ThinkingLevel.high
        let second = ThinkingLevel.high
        let other = ThinkingLevel.low
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    // MARK: - String(describing:)-based types

    @Test func harmBlockThresholdEquality() {
        let first = HarmBlockThreshold.blockNone
        let second = HarmBlockThreshold.blockNone
        let other = HarmBlockThreshold.blockOnlyHigh
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func harmBlockMethodEquality() {
        let first = HarmBlockMethod.severity
        let second = HarmBlockMethod.severity
        let other = HarmBlockMethod.probability
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func responseModalityEquality() {
        let first = ResponseModality.text
        let second = ResponseModality.text
        let other = ResponseModality.image
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func imagenSafetyFilterLevelEquality() {
        let first = ImagenSafetyFilterLevel.blockNone
        let second = ImagenSafetyFilterLevel.blockNone
        let other = ImagenSafetyFilterLevel.blockOnlyHigh
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func imagenPersonFilterLevelEquality() {
        let first = ImagenPersonFilterLevel.blockAll
        let second = ImagenPersonFilterLevel.blockAll
        let other = ImagenPersonFilterLevel.allowAll
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func imagenAspectRatioEquality() {
        let first = ImagenAspectRatio.square1x1
        let second = ImagenAspectRatio.square1x1
        let other = ImagenAspectRatio.landscape16x9
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    // MARK: - ImageConfig enum-like types

    @Test func imageConfigAspectRatioEquality() {
        let first = ImageConfigAspectRatio.square1x1
        let second = ImageConfigAspectRatio.square1x1
        let other = ImageConfigAspectRatio.landscape16x9
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func imageConfigImageSizeEquality() {
        let first = ImageConfigImageSize.size1K
        let second = ImageConfigImageSize.size1K
        let other = ImageConfigImageSize.size4K
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    // MARK: - CodableProtoEnum-based types

    @Test func executableCodeLanguageEquality() {
        let first = ExecutableCodeLanguage.python
        let second = ExecutableCodeLanguage.python
        #expect(first.isEqual(second))
        #expect(first.hash == second.hash)
    }

    @Test func codeExecutionOutcomeEquality() {
        let first = CodeExecutionOutcome.ok
        let second = CodeExecutionOutcome.ok
        let other = CodeExecutionOutcome.failed
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    @Test func urlRetrievalStatusEquality() {
        let first = URLRetrievalStatus.success
        let second = URLRetrievalStatus.success
        let other = URLRetrievalStatus.error
        #expect(first.isEqual(second))
        #expect(!first.isEqual(other))
        #expect(first.hash == second.hash)
    }

    // MARK: - Cross-type comparison returns false

    @Test func crossTypeComparisonReturnsFalse() {
        let harmCategory = HarmCategory.harassment
        let finishReason = FinishReason.stop
        #expect(!harmCategory.isEqual(finishReason))
    }

    @Test func nilComparisonReturnsFalse() {
        let harmCategory = HarmCategory.harassment
        #expect(!harmCategory.isEqual(nil))
    }
}
