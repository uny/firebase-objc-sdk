import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBContentModality)
public final class ContentModality: NSObject {
    let value: FirebaseAILogic.ContentModality

    init(value: FirebaseAILogic.ContentModality) {
        self.value = value
        super.init()
    }

    @objc public var rawValue: String { value.rawValue }

    @objc public static var text: ContentModality {
        ContentModality(value: .text)
    }

    @objc public static var image: ContentModality {
        ContentModality(value: .image)
    }

    @objc public static var video: ContentModality {
        ContentModality(value: .video)
    }

    @objc public static var audio: ContentModality {
        ContentModality(value: .audio)
    }

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
