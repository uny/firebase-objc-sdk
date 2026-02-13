import FirebaseAILogic
import Foundation

/// Categories of potentially harmful content.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBHarmCategory)
public final class HarmCategory: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.HarmCategory

    init(value: FirebaseAILogic.HarmCategory) {
        self.value = value
        super.init()
    }

    /// The raw string value of the harm category.
    @objc public var rawValue: String { value.rawValue }

    /// Harassment content.
    @objc public static var harassment: HarmCategory {
        HarmCategory(value: .harassment)
    }

    /// Hate speech content.
    @objc public static var hateSpeech: HarmCategory {
        HarmCategory(value: .hateSpeech)
    }

    /// Sexually explicit content.
    @objc public static var sexuallyExplicit: HarmCategory {
        HarmCategory(value: .sexuallyExplicit)
    }

    /// Dangerous content.
    @objc public static var dangerousContent: HarmCategory {
        HarmCategory(value: .dangerousContent)
    }

    /// Civic integrity content.
    @objc public static var civicIntegrity: HarmCategory {
        HarmCategory(value: .civicIntegrity)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? HarmCategory else { return false }
        return value.rawValue == other.value.rawValue
    }

    override public var hash: Int {
        value.rawValue.hashValue
    }
}
