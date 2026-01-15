import Foundation
import FirebaseAILogic

@objc(KFBBackend)
public class Backend: NSObject {
    let value: FirebaseAILogic.Backend

    init(value: FirebaseAILogic.Backend) {
        self.value = value
        super.init()
    }

    @objc public static func googleAI() -> Backend {
        return Backend(value: .googleAI())
    }

    @objc public static func vertexAI() -> Backend {
        return Backend(value: .vertexAI())
    }

    @objc public static func vertexAI(location: String) -> Backend {
        return Backend(value: .vertexAI(location: location))
    }
}
