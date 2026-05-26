import FirebaseAILogic
import Foundation

/// Configuration options for generating images with Gemini models.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImageConfig)
public final class ImageConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImageConfig

    init(value: FirebaseAILogic.ImageConfig) {
        self.value = value
        super.init()
    }

    @objc public init(aspectRatio: ImageConfigAspectRatio?, imageSize: ImageConfigImageSize?) {
        self.value = FirebaseAILogic.ImageConfig(
            aspectRatio: aspectRatio?.value,
            imageSize: imageSize?.value
        )
        super.init()
    }
}

/// An aspect ratio for generated images.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImageConfigAspectRatio)
public final class ImageConfigAspectRatio: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImageConfig.AspectRatio

    init(value: FirebaseAILogic.ImageConfig.AspectRatio) {
        self.value = value
        super.init()
    }

    @objc public static var square1x1: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .square1x1)
    }

    @objc public static var portrait9x16: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .portrait9x16)
    }

    @objc public static var landscape16x9: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .landscape16x9)
    }

    @objc public static var portrait3x4: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .portrait3x4)
    }

    @objc public static var landscape4x3: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .landscape4x3)
    }

    @objc public static var portrait2x3: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .portrait2x3)
    }

    @objc public static var landscape3x2: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .landscape3x2)
    }

    @objc public static var portrait4x5: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .portrait4x5)
    }

    @objc public static var landscape5x4: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .landscape5x4)
    }

    @objc public static var portrait1x4: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .portrait1x4)
    }

    @objc public static var landscape4x1: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .landscape4x1)
    }

    @objc public static var portrait1x8: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .portrait1x8)
    }

    @objc public static var landscape8x1: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .landscape8x1)
    }

    @objc public static var ultrawide21x9: ImageConfigAspectRatio {
        ImageConfigAspectRatio(value: .ultrawide21x9)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ImageConfigAspectRatio else { return false }
        return value == other.value
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}

/// The size of images to generate.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBImageConfigImageSize)
public final class ImageConfigImageSize: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.ImageConfig.ImageSize

    init(value: FirebaseAILogic.ImageConfig.ImageSize) {
        self.value = value
        super.init()
    }

    @objc public static var size512: ImageConfigImageSize {
        ImageConfigImageSize(value: .size512)
    }

    @objc public static var size1K: ImageConfigImageSize {
        ImageConfigImageSize(value: .size1K)
    }

    @objc public static var size2K: ImageConfigImageSize {
        ImageConfigImageSize(value: .size2K)
    }

    @objc public static var size4K: ImageConfigImageSize {
        ImageConfigImageSize(value: .size4K)
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ImageConfigImageSize else { return false }
        return value == other.value
    }

    override public var hash: Int {
        String(describing: value).hashValue
    }
}
