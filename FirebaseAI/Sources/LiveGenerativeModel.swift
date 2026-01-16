import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveGenerativeModel)
public final class LiveGenerativeModel: NSObject {
    let value: FirebaseAILogic.LiveGenerativeModel

    init(value: FirebaseAILogic.LiveGenerativeModel) {
        self.value = value
        super.init()
    }

    @objc public func connect() async throws -> LiveSession {
        let session = try await value.connect()
        return LiveSession(value: session)
    }
}
