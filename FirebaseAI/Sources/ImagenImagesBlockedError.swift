import FirebaseAILogic
import Foundation

/// An error indicating that Imagen image generation was blocked.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenImagesBlockedError)
public final class ImagenImagesBlockedError: NSObject, @unchecked Sendable {
    /// The error message describing why images were blocked.
    @objc public let message: String

    private init(message: String) {
        self.message = message
        super.init()
    }

    /// Extracts an `ImagenImagesBlockedError` from an `NSError` if it wraps a
    /// `FirebaseAILogic.ImagenImagesBlockedError`.
    ///
    /// - Parameter error: The `NSError` to extract from.
    /// - Returns: An `ImagenImagesBlockedError` if the error matches, or `nil`.
    @objc public static func from(_ error: NSError) -> ImagenImagesBlockedError? {
        guard error is FirebaseAILogic.ImagenImagesBlockedError else {
            return nil
        }
        let message = error.userInfo[NSLocalizedDescriptionKey] as? String ?? error.localizedDescription
        return ImagenImagesBlockedError(message: message)
    }
}
