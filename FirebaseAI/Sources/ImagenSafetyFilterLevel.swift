import FirebaseAILogic
import Foundation

/// Safety filter levels for Imagen image generation.
///
/// > Warning: All Imagen models are deprecated and will shut down as early as June 2026.
/// > As a replacement, migrate your apps to use Gemini Image models (the "Nano Banana" models).
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(
    *,
    deprecated,
    message: "All Imagen models are deprecated and will shut down as early as June 2026. As a replacement, you can migrate your apps to use Gemini Image models (the \"Nano Banana\" models)."
)
@objc(KFBImagenSafetyFilterLevel)
public final class ImagenSafetyFilterLevel: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImagenSafetyFilterLevel

    init(value: FirebaseAILogic.ImagenSafetyFilterLevel) {
        self.value = value
        super.init()
    }

    /// Block content with low safety risk and above.
    @objc public static var blockLowAndAbove: ImagenSafetyFilterLevel {
        return ImagenSafetyFilterLevel(value: .blockLowAndAbove)
    }

    /// Block content with medium safety risk and above.
    @objc public static var blockMediumAndAbove: ImagenSafetyFilterLevel {
        return ImagenSafetyFilterLevel(value: .blockMediumAndAbove)
    }

    /// Block only content with high safety risk.
    @objc public static var blockOnlyHigh: ImagenSafetyFilterLevel {
        return ImagenSafetyFilterLevel(value: .blockOnlyHigh)
    }

    /// Do not block any content.
    @objc public static var blockNone: ImagenSafetyFilterLevel {
        return ImagenSafetyFilterLevel(value: .blockNone)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ImagenSafetyFilterLevel else { return false }
        return String(describing: value) == String(describing: other.value)
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}
