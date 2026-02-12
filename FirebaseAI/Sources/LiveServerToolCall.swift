import FirebaseAILogic
import Foundation

/// A tool call request from the server during a live session.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerToolCall)
public final class LiveServerToolCall: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.LiveServerToolCall

    init(value: FirebaseAILogic.LiveServerToolCall) {
        self.value = value
        super.init()
    }

    /// The function calls requested by the server.
    @objc public var functionCalls: [FunctionCallPart]? {
        return value.functionCalls?.map { FunctionCallPart(value: $0) }
    }
}
