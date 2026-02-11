import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBModelName)
public final class ModelName: NSObject {
    // Gemini 3
    @objc public static let gemini3ProPreview = "gemini-3-pro-preview"
    @objc public static let gemini3FlashPreview = "gemini-3-flash-preview"
    @objc public static let gemini3ProImagePreview = "gemini-3-pro-image-preview"

    // Gemini 2.5
    @objc public static let gemini25Pro = "gemini-2.5-pro"
    @objc public static let gemini25Flash = "gemini-2.5-flash"
    @objc public static let gemini25FlashLite = "gemini-2.5-flash-lite"
    @objc public static let gemini25FlashImage = "gemini-2.5-flash-image"

    // Imagen
    @objc public static let imagen4Generate = "imagen-4.0-generate-001"
    @objc public static let imagen4FastGenerate = "imagen-4.0-fast-generate-001"
    @objc public static let imagen4UltraGenerate = "imagen-4.0-ultra-generate-001"
}
