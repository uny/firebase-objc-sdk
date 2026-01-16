import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGoogleSearch)
public final class GoogleSearch: NSObject {
    let value: FirebaseAILogic.GoogleSearch

    init(value: FirebaseAILogic.GoogleSearch) {
        self.value = value
        super.init()
    }

    @objc public override init() {
        self.value = FirebaseAILogic.GoogleSearch()
        super.init()
    }
}
