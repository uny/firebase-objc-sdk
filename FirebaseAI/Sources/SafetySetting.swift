import FirebaseAILogic
import Foundation

/// A safety setting that controls content filtering.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSafetySetting)
public final class SafetySetting: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.SafetySetting

    init(value: FirebaseAILogic.SafetySetting) {
        self.value = value
        super.init()
    }

    /// Creates a safety setting with a harm category and block threshold.
    ///
    /// - Parameters:
    ///   - harmCategory: The category of harmful content to filter.
    ///   - threshold: The threshold at which content is blocked.
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

    /// Creates a safety setting with a harm category, block threshold, and block method.
    ///
    /// - Parameters:
    ///   - harmCategory: The category of harmful content to filter.
    ///   - threshold: The threshold at which content is blocked.
    ///   - method: The method used to apply the block threshold.
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

    /// The category of harmful content this setting applies to.
    @objc public var harmCategory: HarmCategory {
        HarmCategory(value: value.harmCategory)
    }

    /// The threshold at which content is blocked for this category.
    @objc public var threshold: HarmBlockThreshold {
        HarmBlockThreshold(value: value.threshold)
    }

    /// The method used to apply the block threshold, or `nil` if not specified.
    @objc public var method: HarmBlockMethod? {
        value.method.map { HarmBlockMethod(value: $0) }
    }
}
