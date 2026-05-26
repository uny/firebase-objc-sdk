import FirebaseAILogic
import Foundation

/// A grounding chunk sourced from Google Maps.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGoogleMapsGroundingChunk)
public final class GoogleMapsGroundingChunk: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.GoogleMapsGroundingChunk

    init(value: FirebaseAILogic.GoogleMapsGroundingChunk) {
        self.value = value
        super.init()
    }

    /// The URL of the retrieved map data.
    @objc public var url: URL? { value.url }

    /// The title of the retrieved map data.
    @objc public var title: String? { value.title }

    /// The Place ID of the retrieved map data.
    @objc public var placeID: String? { value.placeID }
}
