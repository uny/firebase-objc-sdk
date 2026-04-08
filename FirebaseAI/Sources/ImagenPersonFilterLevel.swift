import FirebaseAILogic
import Foundation

/// Filter levels for person detection in Imagen.
///
/// > Warning: All Imagen models are deprecated and will shut down as early as June 2026.
/// > As a replacement, migrate your apps to use Gemini Image models (the "Nano Banana" models).
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(
    *,
    deprecated,
    message: "All Imagen models are deprecated and will shut down as early as June 2026. As a replacement, you can migrate your apps to use Gemini Image models (the \"Nano Banana\" models)."
)
@objc(KFBImagenPersonFilterLevel)
public final class ImagenPersonFilterLevel: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImagenPersonFilterLevel

    init(value: FirebaseAILogic.ImagenPersonFilterLevel) {
        self.value = value
        super.init()
    }

    /// Block all images containing people.
    @objc public static var blockAll: ImagenPersonFilterLevel {
        return ImagenPersonFilterLevel(value: .blockAll)
    }

    /// Allow images containing adults only.
    @objc public static var allowAdult: ImagenPersonFilterLevel {
        return ImagenPersonFilterLevel(value: .allowAdult)
    }

    /// Allow all images containing people.
    @objc public static var allowAll: ImagenPersonFilterLevel {
        return ImagenPersonFilterLevel(value: .allowAll)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ImagenPersonFilterLevel else { return false }
        return String(describing: value) == String(describing: other.value)
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}
