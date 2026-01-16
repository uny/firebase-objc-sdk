import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenPersonFilterLevel)
public final class ImagenPersonFilterLevel: NSObject {
    let value: FirebaseAILogic.ImagenPersonFilterLevel

    init(value: FirebaseAILogic.ImagenPersonFilterLevel) {
        self.value = value
        super.init()
    }

    @objc public static var blockAll: ImagenPersonFilterLevel {
        return ImagenPersonFilterLevel(value: .blockAll)
    }

    @objc public static var allowAdult: ImagenPersonFilterLevel {
        return ImagenPersonFilterLevel(value: .allowAdult)
    }

    @objc public static var allowAll: ImagenPersonFilterLevel {
        return ImagenPersonFilterLevel(value: .allowAll)
    }
}
