import FirebaseAILogic
import Foundation

// MARK: - CodeExecutionOutcome

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCodeExecutionOutcome)
public final class CodeExecutionOutcome: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.CodeExecutionResultPart.Outcome

    init(value: FirebaseAILogic.CodeExecutionResultPart.Outcome) {
        self.value = value
        super.init()
    }

    @objc public static let ok = CodeExecutionOutcome(value: .ok)
    @objc public static let failed = CodeExecutionOutcome(value: .failed)
    @objc public static let deadlineExceeded = CodeExecutionOutcome(value: .deadlineExceeded)

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CodeExecutionOutcome else { return false }
        return value == other.value
    }

    public override var hash: Int {
        switch value {
        case .ok: return 0
        case .failed: return 1
        case .deadlineExceeded: return 2
        default: return 3
        }
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
        if value.outcome == .ok {
            return CodeExecutionOutcome.ok
        } else if value.outcome == .failed {
            return CodeExecutionOutcome.failed
        } else if value.outcome == .deadlineExceeded {
            return CodeExecutionOutcome.deadlineExceeded
        } else {
            return CodeExecutionOutcome(value: value.outcome)
        }
    }

    @objc public var output: String? {
        value.output
    }

    @objc public var isThought: Bool {
        value.isThought
    }
}
