import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenSafetyFilterLevel)
public final class ImagenSafetyFilterLevel: NSObject {
    let value: FirebaseAILogic.ImagenSafetyFilterLevel

    init(value: FirebaseAILogic.ImagenSafetyFilterLevel) {
        self.value = value
        super.init()
    }

    @objc public static var blockLowAndAbove: ImagenSafetyFilterLevel {
        return ImagenSafetyFilterLevel(value: .blockLowAndAbove)
    }

    @objc public static var blockMediumAndAbove: ImagenSafetyFilterLevel {
        return ImagenSafetyFilterLevel(value: .blockMediumAndAbove)
    }

    @objc public static var blockOnlyHigh: ImagenSafetyFilterLevel {
        return ImagenSafetyFilterLevel(value: .blockOnlyHigh)
    }

    @objc public static var blockNone: ImagenSafetyFilterLevel {
        return ImagenSafetyFilterLevel(value: .blockNone)
    }
}
