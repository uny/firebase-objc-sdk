import FirebaseAILogic
import Foundation

// MARK: - ExecutableCodeLanguage

/// Programming language for executable code.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBExecutableCodeLanguage)
public final class ExecutableCodeLanguage: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ExecutableCodePart.Language

    init(value: FirebaseAILogic.ExecutableCodePart.Language) {
        self.value = value
        super.init()
    }

    @objc public static var python: ExecutableCodeLanguage {
        ExecutableCodeLanguage(value: .python)
    }
}

// MARK: - ExecutableCodePart

/// A part containing executable code.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBExecutableCodePart)
public final class ExecutableCodePart: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ExecutableCodePart

    init(value: FirebaseAILogic.ExecutableCodePart) {
        self.value = value
        super.init()
    }

    /// The programming language of the code.
    @objc public var language: ExecutableCodeLanguage {
        ExecutableCodeLanguage(value: value.language)
    }

    /// The source code string.
    @objc public var code: String {
        value.code
    }

    /// Whether this part is a model thought.
    @objc public var isThought: Bool {
        value.isThought
    }
}
