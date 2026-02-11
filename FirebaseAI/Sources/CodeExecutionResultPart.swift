import FirebaseAILogic
import Foundation

// MARK: - CodeExecutionOutcome

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCodeExecutionOutcome)
public final class CodeExecutionOutcome: NSObject {
    let value: FirebaseAILogic.CodeExecutionResultPart.Outcome

    init(value: FirebaseAILogic.CodeExecutionResultPart.Outcome) {
        self.value = value
        super.init()
    }

    @objc public static var ok: CodeExecutionOutcome {
        CodeExecutionOutcome(value: .ok)
    }

    @objc public static var failed: CodeExecutionOutcome {
        CodeExecutionOutcome(value: .failed)
    }

    @objc public static var deadlineExceeded: CodeExecutionOutcome {
        CodeExecutionOutcome(value: .deadlineExceeded)
    }
}

// MARK: - CodeExecutionResultPart

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCodeExecutionResultPart)
public final class CodeExecutionResultPart: NSObject {
    let value: FirebaseAILogic.CodeExecutionResultPart

    init(value: FirebaseAILogic.CodeExecutionResultPart) {
        self.value = value
        super.init()
    }

    @objc public var outcome: CodeExecutionOutcome {
        CodeExecutionOutcome(value: value.outcome)
    }

    @objc public var output: String? {
        value.output
    }

    @objc public var isThought: Bool {
        value.isThought
    }
}
