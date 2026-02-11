import FirebaseAILogic
import Foundation

// MARK: - URLRetrievalStatus

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBURLRetrievalStatus)
public final class URLRetrievalStatus: NSObject {
    let value: FirebaseAILogic.URLMetadata.URLRetrievalStatus

    init(value: FirebaseAILogic.URLMetadata.URLRetrievalStatus) {
        self.value = value
        super.init()
    }

    @objc public static var success: URLRetrievalStatus {
        URLRetrievalStatus(value: .success)
    }

    @objc public static var error: URLRetrievalStatus {
        URLRetrievalStatus(value: .error)
    }

    @objc public static var paywall: URLRetrievalStatus {
        URLRetrievalStatus(value: .paywall)
    }

    @objc public static var unsafe: URLRetrievalStatus {
        URLRetrievalStatus(value: .unsafe)
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
        URLRetrievalStatus(value: value.retrievalStatus)
    }
}
