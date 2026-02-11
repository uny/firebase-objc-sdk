import FirebaseAILogic
import Foundation

// MARK: - ExecutableCodeLanguage

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBExecutableCodeLanguage)
public final class ExecutableCodeLanguage: NSObject {
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

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBExecutableCodePart)
public final class ExecutableCodePart: NSObject {
    let value: FirebaseAILogic.ExecutableCodePart

    init(value: FirebaseAILogic.ExecutableCodePart) {
        self.value = value
        super.init()
    }

    @objc public var language: ExecutableCodeLanguage {
        ExecutableCodeLanguage(value: value.language)
    }

    @objc public var code: String {
        value.code
    }

    @objc public var isThought: Bool {
        value.isThought
    }
}
