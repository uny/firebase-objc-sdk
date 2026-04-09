import FirebaseAILogic
import Foundation

// MARK: - CodeExecutionOutcome

/// Outcome of code execution.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCodeExecutionOutcome)
public final class CodeExecutionOutcome: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.CodeExecutionResultPart.Outcome

    init(value: FirebaseAILogic.CodeExecutionResultPart.Outcome) {
        self.value = value
        super.init()
    }

    /// The code executed successfully.
    @objc public static let ok = CodeExecutionOutcome(value: .ok) // swiftlint:disable:this identifier_name
    /// The code execution failed.
    @objc public static let failed = CodeExecutionOutcome(value: .failed)
    /// The code execution exceeded the time limit.
    @objc public static let deadlineExceeded = CodeExecutionOutcome(value: .deadlineExceeded)

    /// The raw string value of the outcome.
    @objc public var rawValue: String {
        String(describing: value)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CodeExecutionOutcome else { return false }
        return value == other.value
    }

    override public var hash: Int {
        switch value {
        case .ok: return 0
        case .failed: return 1
        case .deadlineExceeded: return 2
        default: return 3
        }
    }
}

// MARK: - CodeExecutionResultPart

/// A part containing the result of code execution.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCodeExecutionResultPart)
public final class CodeExecutionResultPart: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.CodeExecutionResultPart

    init(value: FirebaseAILogic.CodeExecutionResultPart) {
        self.value = value
        super.init()
    }

    /// The outcome of the code execution.
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

    /// The output produced by the code execution, if any.
    @objc public var output: String? {
        value.output
    }

    /// Whether this part is a model thought.
    @objc public var isThought: Bool {
        value.isThought
    }
}
