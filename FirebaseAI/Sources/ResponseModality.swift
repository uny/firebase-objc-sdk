import FirebaseAILogic
import Foundation

/// Response modalities that can be requested from the model.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBResponseModality)
public final class ResponseModality: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ResponseModality

    init(value: FirebaseAILogic.ResponseModality) {
        self.value = value
        super.init()
    }

    /// Request text output from the model.
    @objc public static var text: ResponseModality {
        return ResponseModality(value: .text)
    }

    /// Request image output from the model.
    @objc public static var image: ResponseModality {
        return ResponseModality(value: .image)
    }

    /// Request audio output from the model.
    @objc public static var audio: ResponseModality {
        return ResponseModality(value: .audio)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ResponseModality else { return false }
        return String(describing: value) == String(describing: other.value)
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}
