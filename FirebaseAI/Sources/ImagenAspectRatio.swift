import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenAspectRatio)
public final class ImagenAspectRatio: NSObject {
    let value: FirebaseAILogic.ImagenAspectRatio

    init(value: FirebaseAILogic.ImagenAspectRatio) {
        self.value = value
        super.init()
    }

    @objc public static var square1x1: ImagenAspectRatio {
        return ImagenAspectRatio(value: .square1x1)
    }

    @objc public static var portrait9x16: ImagenAspectRatio {
        return ImagenAspectRatio(value: .portrait9x16)
    }

    @objc public static var landscape16x9: ImagenAspectRatio {
        return ImagenAspectRatio(value: .landscape16x9)
    }

    @objc public static var portrait3x4: ImagenAspectRatio {
        return ImagenAspectRatio(value: .portrait3x4)
    }

    @objc public static var landscape4x3: ImagenAspectRatio {
        return ImagenAspectRatio(value: .landscape4x3)
    }
}
