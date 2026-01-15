import FirebaseAILogic
import FirebaseCore
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(FIRFirebaseAI)
public final class FirebaseAI: NSObject {
    let value: FirebaseAILogic.FirebaseAI

    init(value: FirebaseAILogic.FirebaseAI) {
        self.value = value
    }

    @objc static func firebaseAI(
        app: FirebaseCore.FirebaseApp? = nil,
        backend: Backend = .googleAI(),
        useLimitedUseAppCheckTokens: Bool = false,
    ) -> FirebaseAI {
        return FirebaseAI(
            value: FirebaseAILogic.FirebaseAI.firebaseAI(
                app: app,
                backend: backend.value,
                useLimitedUseAppCheckTokens: useLimitedUseAppCheckTokens,
            ),
        )
    }
}
