import FirebaseAILogic
import Foundation

/// Safety filter levels for Imagen image generation.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
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

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ImagenSafetyFilterLevel else { return false }
        return String(describing: value) == String(describing: other.value)
    }

    public override var hash: Int {
        String(describing: value).hashValue
    }
}
