import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBTextPart)
public final class TextPart: NSObject {
    let value: FirebaseAILogic.TextPart

    init(value: FirebaseAILogic.TextPart) {
        self.value = value
        super.init()
    }

    @objc public convenience init(text: String) {
        self.init(value: FirebaseAILogic.TextPart(text))
    }

    @objc public var text: String {
        value.text
    }

    @objc public var isThought: Bool {
        value.isThought
    }
}
