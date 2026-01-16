import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBInlineDataPart)
public final class InlineDataPart: NSObject {
    let value: FirebaseAILogic.InlineDataPart

    init(value: FirebaseAILogic.InlineDataPart) {
        self.value = value
        super.init()
    }

    @objc public convenience init(data: Data, mimeType: String) {
        self.init(value: FirebaseAILogic.InlineDataPart(data: data, mimeType: mimeType))
    }

    @objc public var data: Data {
        value.data
    }

    @objc public var mimeType: String {
        value.mimeType
    }

    @objc public var isThought: Bool {
        value.isThought
    }
}
