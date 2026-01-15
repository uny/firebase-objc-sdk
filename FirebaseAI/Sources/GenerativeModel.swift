import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerativeModel)
public final class GenerativeModel: NSObject {
    let value: FirebaseAILogic.GenerativeModel

    init(value: FirebaseAILogic.GenerativeModel) {
        self.value = value
        super.init()
    }
}
