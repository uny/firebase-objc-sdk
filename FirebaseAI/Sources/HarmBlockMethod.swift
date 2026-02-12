import FirebaseAILogic
import Foundation

/// Methods for applying harm blocking.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHarmBlockMethod)
public final class HarmBlockMethod: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.SafetySetting.HarmBlockMethod

    init(value: FirebaseAILogic.SafetySetting.HarmBlockMethod) {
        self.value = value
        super.init()
    }

    /// Block based on severity of harmful content.
    @objc public static var severity: HarmBlockMethod {
        HarmBlockMethod(value: .severity)
    }

    /// Block based on probability of harmful content.
    @objc public static var probability: HarmBlockMethod {
        HarmBlockMethod(value: .probability)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? HarmBlockMethod else { return false }
        return String(describing: value) == String(describing: other.value)
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}
