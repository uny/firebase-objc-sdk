import FirebaseAILogic
import Foundation

/// Filter levels for person detection in Imagen.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
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

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ImagenPersonFilterLevel else { return false }
        return String(describing: value) == String(describing: other.value)
    }

    public override var hash: Int {
        String(describing: value).hashValue
    }
}
