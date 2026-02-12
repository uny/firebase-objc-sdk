import FirebaseAILogic
import Foundation

/// Options for API request behavior.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBRequestOptions)
public final class RequestOptions: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.RequestOptions

    init(value: FirebaseAILogic.RequestOptions) {
        self.value = value
        super.init()
    }

    /// Creates request options with the given timeout.
    /// - Parameter timeout: The request timeout interval in seconds.
    @objc public init(timeout: TimeInterval) {
        self.value = FirebaseAILogic.RequestOptions(timeout: timeout)
        super.init()
    }
}
