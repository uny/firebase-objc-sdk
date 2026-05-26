import CoreLocation
import FirebaseAILogic
import Foundation

/// Retrieval configuration for tool usage.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBRetrievalConfig)
public final class RetrievalConfig: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.RetrievalConfig

    init(value: FirebaseAILogic.RetrievalConfig) {
        self.value = value
        super.init()
    }

    /// Creates a retrieval configuration.
    /// - Parameters:
    ///   - latitude: The latitude for the search location, or `nil` to omit location.
    ///   - longitude: The longitude for the search location, or `nil` to omit location.
    ///   - languageCode: The language code of the user, or `nil` for default.
    @objc public init(latitude: NSNumber?, longitude: NSNumber?, languageCode: String?) {
        let location: CLLocationCoordinate2D?
        if let latitude, let longitude {
            location = CLLocationCoordinate2D(
                latitude: latitude.doubleValue,
                longitude: longitude.doubleValue
            )
        } else {
            location = nil
        }
        self.value = FirebaseAILogic.RetrievalConfig(
            location: location,
            languageCode: languageCode
        )
        super.init()
    }
}
