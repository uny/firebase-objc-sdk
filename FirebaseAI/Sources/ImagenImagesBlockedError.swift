import FirebaseAILogic
import Foundation

/// An error indicating that Imagen image generation was blocked.
///
/// > Warning: All Imagen models are deprecated and will shut down as early as June 2026.
/// > As a replacement, migrate your apps to use Gemini Image models (the "Nano Banana" models).
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(
    *,
    deprecated,
    message: "All Imagen models are deprecated and will shut down as early as June 2026. As a replacement, you can migrate your apps to use Gemini Image models (the \"Nano Banana\" models)."
)
@objc(KFBImagenImagesBlockedError)
public final class ImagenImagesBlockedError: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImagenImagesBlockedError

    /// The error message describing why images were blocked.
    @objc public let message: String

    init(value: FirebaseAILogic.ImagenImagesBlockedError) {
        self.value = value
        self.message = value.localizedDescription
        super.init()
    }

    private init(value: FirebaseAILogic.ImagenImagesBlockedError, message: String) {
        self.value = value
        self.message = message
        super.init()
    }

    /// Extracts an `ImagenImagesBlockedError` from an `NSError` if it wraps a
    /// `FirebaseAILogic.ImagenImagesBlockedError`.
    ///
    /// - Parameter error: The `NSError` to extract from.
    /// - Returns: An `ImagenImagesBlockedError` if the error matches, or `nil`.
    @objc public static func from(_ error: NSError) -> ImagenImagesBlockedError? {
        guard let underlying = error as? FirebaseAILogic.ImagenImagesBlockedError else {
            return nil
        }
        let message = error.userInfo[NSLocalizedDescriptionKey] as? String ?? error.localizedDescription
        return ImagenImagesBlockedError(value: underlying, message: message)
    }
}
