import Foundation
import FirebaseAILogic

@objc(FIRBackend)
public class Backend: NSObject {
    let value: FirebaseAILogic.Backend
    
    init(value: FirebaseAILogic.Backend) {
        self.value = value
    }
    
    @objc public static func vertexAI(location: String = "us-central1") -> Backend {
        return Backend(value: .vertexAI(location: location))
    }
    
    @objc public static func googleAI() -> Backend {
        return Backend(value: .googleAI())
    }
}
