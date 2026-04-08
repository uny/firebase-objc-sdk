import FirebaseAILogic
import Foundation

/// Safety settings for Imagen image generation.
///
/// > Warning: All Imagen models are deprecated and will shut down as early as June 2026.
/// > As a replacement, migrate your apps to use Gemini Image models (the "Nano Banana" models).
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(
    *,
    deprecated,
    message: "All Imagen models are deprecated and will shut down as early as June 2026. As a replacement, you can migrate your apps to use Gemini Image models (the \"Nano Banana\" models)."
)
@objc(KFBImagenSafetySettings)
public final class ImagenSafetySettings: NSObject, @unchecked Sendable {
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
