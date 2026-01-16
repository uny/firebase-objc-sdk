import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerToolCallCancellation)
public final class LiveServerToolCallCancellation: NSObject {
    let value: FirebaseAILogic.LiveServerToolCallCancellation

    init(value: FirebaseAILogic.LiveServerToolCallCancellation) {
        self.value = value
        super.init()
    }

    @objc public var ids: [String]? {
        return value.ids
    }
}
