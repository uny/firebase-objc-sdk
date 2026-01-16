import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerMessagePayloadType)
public enum LiveServerMessagePayloadType: Int {
    case content
    case toolCall
    case toolCallCancellation
    case goingAwayNotice
}

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerMessage)
public final class LiveServerMessage: NSObject {
    let value: FirebaseAILogic.LiveServerMessage

    init(value: FirebaseAILogic.LiveServerMessage) {
        self.value = value
        super.init()
    }

    @objc public var payloadType: LiveServerMessagePayloadType {
        switch value.payload {
        case .content:
            return .content
        case .toolCall:
            return .toolCall
        case .toolCallCancellation:
            return .toolCallCancellation
        case .goingAwayNotice:
            return .goingAwayNotice
        }
    }

    @objc public var content: LiveServerContent? {
        if case .content(let content) = value.payload {
            return LiveServerContent(value: content)
        }
        return nil
    }

    @objc public var toolCall: LiveServerToolCall? {
        if case .toolCall(let toolCall) = value.payload {
            return LiveServerToolCall(value: toolCall)
        }
        return nil
    }

    @objc public var toolCallCancellation: LiveServerToolCallCancellation? {
        if case .toolCallCancellation(let cancellation) = value.payload {
            return LiveServerToolCallCancellation(value: cancellation)
        }
        return nil
    }

    @objc public var goingAwayNotice: LiveServerGoingAwayNotice? {
        if case .goingAwayNotice(let notice) = value.payload {
            return LiveServerGoingAwayNotice(value: notice)
        }
        return nil
    }

    @objc public var usageMetadata: UsageMetadata? {
        return value.usageMetadata.map { UsageMetadata(value: $0) }
    }
}
