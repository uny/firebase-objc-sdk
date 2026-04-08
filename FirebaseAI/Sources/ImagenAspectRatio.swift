import FirebaseAILogic
import Foundation

/// Aspect ratios for Imagen-generated images.
///
/// > Warning: All Imagen models are deprecated and will shut down as early as June 2026.
/// > As a replacement, migrate your apps to use Gemini Image models (the "Nano Banana" models).
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(
    *,
    deprecated,
    message: "All Imagen models are deprecated and will shut down as early as June 2026. As a replacement, you can migrate your apps to use Gemini Image models (the \"Nano Banana\" models)."
)
@objc(KFBImagenAspectRatio)
public final class ImagenAspectRatio: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImagenAspectRatio

    init(value: FirebaseAILogic.ImagenAspectRatio) {
        self.value = value
        super.init()
    }

    /// Square 1:1 aspect ratio.
    @objc public static var square1x1: ImagenAspectRatio {
        return ImagenAspectRatio(value: .square1x1)
    }

    /// Portrait 9:16 aspect ratio.
    @objc public static var portrait9x16: ImagenAspectRatio {
        return ImagenAspectRatio(value: .portrait9x16)
    }

    /// Landscape 16:9 aspect ratio.
    @objc public static var landscape16x9: ImagenAspectRatio {
        return ImagenAspectRatio(value: .landscape16x9)
    }

    /// Portrait 3:4 aspect ratio.
    @objc public static var portrait3x4: ImagenAspectRatio {
        return ImagenAspectRatio(value: .portrait3x4)
    }

    /// Landscape 4:3 aspect ratio.
    @objc public static var landscape4x3: ImagenAspectRatio {
        return ImagenAspectRatio(value: .landscape4x3)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ImagenAspectRatio else { return false }
        return String(describing: value) == String(describing: other.value)
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}
