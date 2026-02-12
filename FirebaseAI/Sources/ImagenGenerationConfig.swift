import FirebaseAILogic
import Foundation

/// Configuration for Imagen image generation.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenGenerationConfig)
public final class ImagenGenerationConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImagenGenerationConfig

    init(value: FirebaseAILogic.ImagenGenerationConfig) {
        self.value = value
        super.init()
    }

    /// A text prompt describing what should not be generated.
    @objc public var negativePrompt: String? {
        return value.negativePrompt
    }

    /// The number of images to generate.
    @objc public var numberOfImages: NSNumber? {
        return value.numberOfImages.map { NSNumber(value: $0) }
    }

    /// The aspect ratio of the generated images.
    @objc public var aspectRatio: ImagenAspectRatio? {
        return value.aspectRatio.map { ImagenAspectRatio(value: $0) }
    }

    /// The output format of the generated images.
    @objc public var imageFormat: ImagenImageFormat? {
        return value.imageFormat.map { ImagenImageFormat(value: $0) }
    }

    /// Whether to add a watermark to the generated images.
    @objc public var addWatermark: NSNumber? {
        return value.addWatermark.map { NSNumber(value: $0) }
    }

    @objc public init(
        negativePrompt: String?,
        numberOfImages: NSNumber?,
        aspectRatio: ImagenAspectRatio?,
        imageFormat: ImagenImageFormat?,
        addWatermark: NSNumber?
    ) {
        self.value = FirebaseAILogic.ImagenGenerationConfig(
            negativePrompt: negativePrompt,
            numberOfImages: numberOfImages?.intValue,
            aspectRatio: aspectRatio?.value,
            imageFormat: imageFormat?.value,
            addWatermark: addWatermark?.boolValue
        )
        super.init()
    }
}
