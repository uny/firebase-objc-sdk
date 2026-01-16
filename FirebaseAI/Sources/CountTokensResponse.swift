import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBCountTokensResponse)
public final class CountTokensResponse: NSObject {
    let value: FirebaseAILogic.CountTokensResponse

    init(value: FirebaseAILogic.CountTokensResponse) {
        self.value = value
        super.init()
    }

    @objc public var totalTokens: Int {
        value.totalTokens
    }
}
