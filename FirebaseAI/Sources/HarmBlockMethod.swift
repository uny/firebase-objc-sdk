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
}
