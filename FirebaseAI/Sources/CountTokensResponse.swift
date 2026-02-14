import FirebaseAILogic
import Foundation

/// The response from a token counting request.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCountTokensResponse)
public final class CountTokensResponse: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.CountTokensResponse

    init(value: FirebaseAILogic.CountTokensResponse) {
        self.value = value
        super.init()
    }

    /// The total number of tokens in the input.
    @objc public var totalTokens: Int {
        value.totalTokens
    }
}
