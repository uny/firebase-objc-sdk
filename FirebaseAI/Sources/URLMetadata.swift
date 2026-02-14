import FirebaseAILogic
import Foundation

// MARK: - URLRetrievalStatus

/// Status of a URL retrieval operation.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBURLRetrievalStatus)
public final class URLRetrievalStatus: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.URLMetadata.URLRetrievalStatus

    init(value: FirebaseAILogic.URLMetadata.URLRetrievalStatus) {
        self.value = value
        super.init()
    }

    /// The URL was retrieved successfully.
    @objc public static let success = URLRetrievalStatus(value: .success)
    /// An error occurred during retrieval.
    @objc public static let error = URLRetrievalStatus(value: .error)
    /// The URL is behind a paywall.
    @objc public static let paywall = URLRetrievalStatus(value: .paywall)
    /// The URL was flagged as unsafe.
    @objc public static let unsafe = URLRetrievalStatus(value: .unsafe)

    override public func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? URLRetrievalStatus else { return false }
        return value == other.value
    }

    override public var hash: Int {
        value.hashValue
    }
}

// MARK: - URLMetadata

/// Metadata about a retrieved URL.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBURLMetadata)
public final class URLMetadata: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.URLMetadata

    init(value: FirebaseAILogic.URLMetadata) {
        self.value = value
        super.init()
    }

    /// The URL that was retrieved.
    @objc public var retrievedURL: URL? {
        value.retrievedURL
    }

    /// The status of the URL retrieval operation.
    @objc public var retrievalStatus: URLRetrievalStatus {
        if value.retrievalStatus == .success {
            return URLRetrievalStatus.success
        } else if value.retrievalStatus == .error {
            return URLRetrievalStatus.error
        } else if value.retrievalStatus == .paywall {
            return URLRetrievalStatus.paywall
        } else if value.retrievalStatus == .unsafe {
            return URLRetrievalStatus.unsafe
        } else {
            return URLRetrievalStatus(value: value.retrievalStatus)
        }
    }
}
