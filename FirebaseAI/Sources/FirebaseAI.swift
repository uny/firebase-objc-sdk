import FirebaseAILogic
import FirebaseCore
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFirebaseAI)
public class FirebaseAI: NSObject {
    let value: FirebaseAILogic.FirebaseAI

    init(value: FirebaseAILogic.FirebaseAI) {
        self.value = value
        super.init()
    }

    @objc public static func firebaseAI(
        app: FirebaseCore.FirebaseApp?,
        backend: Backend,
        useLimitedUseAppCheckTokens: Bool,
    ) -> FirebaseAI {
        let ai = FirebaseAILogic.FirebaseAI.firebaseAI(
            app: app,
            backend: backend.value,
            useLimitedUseAppCheckTokens: useLimitedUseAppCheckTokens,
        )
        return FirebaseAI(value: ai)
    }
}
