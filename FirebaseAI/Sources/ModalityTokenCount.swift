import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBModalityTokenCount)
public final class ModalityTokenCount: NSObject {
    let value: FirebaseAILogic.ModalityTokenCount

    init(value: FirebaseAILogic.ModalityTokenCount) {
        self.value = value
        super.init()
    }

    @objc public var modality: ContentModality {
        ContentModality(value: value.modality)
    }

    @objc public var tokenCount: Int {
        value.tokenCount
    }
}
