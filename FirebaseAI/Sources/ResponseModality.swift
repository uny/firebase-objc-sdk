import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBResponseModality)
public final class ResponseModality: NSObject {
    let value: FirebaseAILogic.ResponseModality

    init(value: FirebaseAILogic.ResponseModality) {
        self.value = value
        super.init()
    }

    @objc public static var text: ResponseModality {
        return ResponseModality(value: .text)
    }

    @objc public static var image: ResponseModality {
        return ResponseModality(value: .image)
    }

    @objc public static var audio: ResponseModality {
        return ResponseModality(value: .audio)
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ResponseModality else { return false }
        return String(describing: value) == String(describing: other.value)
    }

    public override var hash: Int {
        String(describing: value).hashValue
    }
}
