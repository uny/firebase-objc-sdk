import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImagenGenerationResponse)
public final class ImagenGenerationResponse: NSObject {
    let value: FirebaseAILogic.ImagenGenerationResponse<FirebaseAILogic.ImagenInlineImage>

    init(value: FirebaseAILogic.ImagenGenerationResponse<FirebaseAILogic.ImagenInlineImage>) {
        self.value = value
        super.init()
    }

    @objc public var images: [ImagenInlineImage] {
        return value.images.map { ImagenInlineImage(value: $0) }
    }

    @objc public var filteredReason: String? {
        return value.filteredReason
    }
}
