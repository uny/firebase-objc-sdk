import FirebaseAILogic
import Foundation

/// Token count for a specific content modality.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBModalityTokenCount)
public final class ModalityTokenCount: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ModalityTokenCount

    init(value: FirebaseAILogic.ModalityTokenCount) {
        self.value = value
        super.init()
    }

    /// The content modality (e.g., text, image, audio).
    @objc public var modality: ContentModality {
        ContentModality(value: value.modality)
    }

    /// The number of tokens for this modality.
    @objc public var tokenCount: Int {
        value.tokenCount
    }
}
