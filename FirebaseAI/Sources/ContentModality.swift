import FirebaseAILogic
import Foundation

/// Content modality types for token counting.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBContentModality)
public final class ContentModality: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ContentModality

    init(value: FirebaseAILogic.ContentModality) {
        self.value = value
        super.init()
    }

    /// The raw string value of the content modality.
    @objc public var rawValue: String { value.rawValue }

    /// Text content modality.
    @objc public static var text: ContentModality {
        ContentModality(value: .text)
    }

    /// Image content modality.
    @objc public static var image: ContentModality {
        ContentModality(value: .image)
    }

    /// Video content modality.
    @objc public static var video: ContentModality {
        ContentModality(value: .video)
    }

    /// Audio content modality.
    @objc public static var audio: ContentModality {
        ContentModality(value: .audio)
    }

    /// Document content modality.
    @objc public static var document: ContentModality {
        ContentModality(value: .document)
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ContentModality else { return false }
        return value.rawValue == other.value.rawValue
    }

    public override var hash: Int {
        value.rawValue.hashValue
    }
}
