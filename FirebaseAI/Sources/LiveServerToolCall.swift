import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerToolCall)
public final class LiveServerToolCall: NSObject {
    let value: FirebaseAILogic.LiveServerToolCall

    init(value: FirebaseAILogic.LiveServerToolCall) {
        self.value = value
        super.init()
    }

    @objc public var functionCalls: [FunctionCallPart]? {
        return value.functionCalls?.map { FunctionCallPart(value: $0) }
    }
}
