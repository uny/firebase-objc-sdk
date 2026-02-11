import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHarmBlockMethod)
public final class HarmBlockMethod: NSObject {
    let value: FirebaseAILogic.SafetySetting.HarmBlockMethod

    init(value: FirebaseAILogic.SafetySetting.HarmBlockMethod) {
        self.value = value
        super.init()
    }

    @objc public static var severity: HarmBlockMethod {
        HarmBlockMethod(value: .severity)
    }

    @objc public static var probability: HarmBlockMethod {
        HarmBlockMethod(value: .probability)
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? HarmBlockMethod else { return false }
        return String(describing: value) == String(describing: other.value)
    }

    public override var hash: Int {
        String(describing: value).hashValue
    }
}
