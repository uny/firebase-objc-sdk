import FirebaseAILogic
import Foundation

/// A part containing text content.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBTextPart)
public final class TextPart: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.TextPart

    init(value: FirebaseAILogic.TextPart) {
        self.value = value
        super.init()
    }

    /// Creates a text part with the given string.
    /// - Parameter text: The text content.
    @objc public convenience init(text: String) {
        self.init(value: FirebaseAILogic.TextPart(text))
    }

    @objc public var text: String {
        value.text
    }

    /// Whether this text part is a model thought.
    @objc public var isThought: Bool {
        value.isThought
    }
}
