import FirebaseAILogic
import Foundation

// MARK: - URLRetrievalStatus

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBURLRetrievalStatus)
public final class URLRetrievalStatus: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.URLMetadata.URLRetrievalStatus

    init(value: FirebaseAILogic.URLMetadata.URLRetrievalStatus) {
        self.value = value
        super.init()
    }

    @objc public static let success = URLRetrievalStatus(value: .success)
    @objc public static let error = URLRetrievalStatus(value: .error)
    @objc public static let paywall = URLRetrievalStatus(value: .paywall)
    @objc public static let unsafe = URLRetrievalStatus(value: .unsafe)

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? URLRetrievalStatus else { return false }
        return value == other.value
    }

    public override var hash: Int {
        value.hashValue
    }
}

// MARK: - URLMetadata

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBURLMetadata)
public final class URLMetadata: NSObject {
    let value: FirebaseAILogic.URLMetadata

    init(value: FirebaseAILogic.URLMetadata) {
        self.value = value
        super.init()
    }

    @objc public var retrievedURL: URL? {
        value.retrievedURL
    }

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
