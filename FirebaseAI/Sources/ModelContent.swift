import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBModelContent)
public final class ModelContent: NSObject {
    let value: FirebaseAILogic.ModelContent

    init(value: FirebaseAILogic.ModelContent) {
        self.value = value
        super.init()
    }

    /// Creates a ModelContent with a text string.
    @objc public convenience init(text: String) {
        self.init(value: FirebaseAILogic.ModelContent(parts: [FirebaseAILogic.TextPart(text)]))
    }

    /// Creates a ModelContent with a role and text string.
    @objc public convenience init(role: String, text: String) {
        self.init(value: FirebaseAILogic.ModelContent(role: role, parts: [FirebaseAILogic.TextPart(text)]))
    }

    /// Creates a ModelContent with a role and array of Part wrapper objects.
    @objc public convenience init(role: String, parts: [NSObject]) {
        let swiftParts: [any FirebaseAILogic.Part] = parts.compactMap { part in
            if let textPart = part as? TextPart {
                return textPart.value
            } else if let inlineDataPart = part as? InlineDataPart {
                return inlineDataPart.value
            } else if let fileDataPart = part as? FileDataPart {
                return fileDataPart.value
            } else if let functionCallPart = part as? FunctionCallPart {
                return functionCallPart.value
            } else if let functionResponsePart = part as? FunctionResponsePart {
                return functionResponsePart.value
            }
            return nil
        }
        self.init(value: FirebaseAILogic.ModelContent(role: role, parts: swiftParts))
    }

    /// Creates a ModelContent with an array of Part wrapper objects (role defaults to "user").
    @objc public convenience init(parts: [NSObject]) {
        let swiftParts: [any FirebaseAILogic.Part] = parts.compactMap { part in
            if let textPart = part as? TextPart {
                return textPart.value
            } else if let inlineDataPart = part as? InlineDataPart {
                return inlineDataPart.value
            } else if let fileDataPart = part as? FileDataPart {
                return fileDataPart.value
            } else if let functionCallPart = part as? FunctionCallPart {
                return functionCallPart.value
            } else if let functionResponsePart = part as? FunctionResponsePart {
                return functionResponsePart.value
            }
            return nil
        }
        self.init(value: FirebaseAILogic.ModelContent(parts: swiftParts))
    }

    @objc public var role: String? {
        value.role
    }

    /// Returns the parts as an array of wrapper objects (TextPart, InlineDataPart, etc.).
    @objc public var parts: [NSObject] {
        value.parts.compactMap { part -> NSObject? in
            if let textPart = part as? FirebaseAILogic.TextPart {
                return TextPart(value: textPart)
            } else if let inlineDataPart = part as? FirebaseAILogic.InlineDataPart {
                return InlineDataPart(value: inlineDataPart)
            } else if let fileDataPart = part as? FirebaseAILogic.FileDataPart {
                return FileDataPart(value: fileDataPart)
            } else if let functionCallPart = part as? FirebaseAILogic.FunctionCallPart {
                return FunctionCallPart(value: functionCallPart)
            } else if let functionResponsePart = part as? FirebaseAILogic.FunctionResponsePart {
                return FunctionResponsePart(value: functionResponsePart)
            }
            return nil
        }
    }
}
