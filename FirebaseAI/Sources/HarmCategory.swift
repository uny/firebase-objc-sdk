import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHarmCategory)
public final class HarmCategory: NSObject {
    let value: FirebaseAILogic.HarmCategory

    init(value: FirebaseAILogic.HarmCategory) {
        self.value = value
        super.init()
    }

    @objc public var rawValue: String { value.rawValue }

    @objc public static var harassment: HarmCategory {
        HarmCategory(value: .harassment)
    }

    @objc public static var hateSpeech: HarmCategory {
        HarmCategory(value: .hateSpeech)
    }

    @objc public static var sexuallyExplicit: HarmCategory {
        HarmCategory(value: .sexuallyExplicit)
    }

    @objc public static var dangerousContent: HarmCategory {
        HarmCategory(value: .dangerousContent)
    }

    @objc public static var civicIntegrity: HarmCategory {
        HarmCategory(value: .civicIntegrity)
    }
}
