import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSafetySetting)
public final class SafetySetting: NSObject {
    let value: FirebaseAILogic.SafetySetting

    init(value: FirebaseAILogic.SafetySetting) {
        self.value = value
        super.init()
    }

    @objc public convenience init(
        harmCategory: HarmCategory,
        threshold: HarmBlockThreshold
    ) {
        let setting = FirebaseAILogic.SafetySetting(
            harmCategory: harmCategory.value,
            threshold: threshold.value
        )
        self.init(value: setting)
    }

    @objc public convenience init(
        harmCategory: HarmCategory,
        threshold: HarmBlockThreshold,
        method: HarmBlockMethod
    ) {
        let setting = FirebaseAILogic.SafetySetting(
            harmCategory: harmCategory.value,
            threshold: threshold.value,
            method: method.value
        )
        self.init(value: setting)
    }

    @objc public var harmCategory: HarmCategory {
        HarmCategory(value: value.harmCategory)
    }

    @objc public var threshold: HarmBlockThreshold {
        HarmBlockThreshold(value: value.threshold)
    }

    @objc public var method: HarmBlockMethod? {
        value.method.map { HarmBlockMethod(value: $0) }
    }
}
