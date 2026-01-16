import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenSafetySettings)
public final class ImagenSafetySettings: NSObject {
    let value: FirebaseAILogic.ImagenSafetySettings

    init(value: FirebaseAILogic.ImagenSafetySettings) {
        self.value = value
        super.init()
    }

    @objc public init(
        safetyFilterLevel: ImagenSafetyFilterLevel?,
        personFilterLevel: ImagenPersonFilterLevel?
    ) {
        self.value = FirebaseAILogic.ImagenSafetySettings(
            safetyFilterLevel: safetyFilterLevel?.value,
            personFilterLevel: personFilterLevel?.value
        )
        super.init()
    }
}
