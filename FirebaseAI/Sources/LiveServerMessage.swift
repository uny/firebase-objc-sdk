import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerMessagePayloadType)
public enum LiveServerMessagePayloadType: Int {
    case content
    case toolCall
    case toolCallCancellation
    case sessionResumptionUpdate
    case goingAwayNotice
}

/// A message received from the server during a live session.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerMessage)
public final class LiveServerMessage: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.LiveServerMessage

    init(value: FirebaseAILogic.LiveServerMessage) {
        self.value = value
        super.init()
    }

    /// The type of the message payload.
    @objc public var payloadType: LiveServerMessagePayloadType {
        switch value.payload {
        case .content:
            return .content
        case .toolCall:
            return .toolCall
        case .toolCallCancellation:
            return .toolCallCancellation
        case .sessionResumptionUpdate:
            return .sessionResumptionUpdate
        case .goingAwayNotice:
            return .goingAwayNotice
        }
    }

    /// The content payload, if this message contains content.
    @objc public var content: LiveServerContent? {
        if case .content(let content) = value.payload {
            return LiveServerContent(value: content)
        }
        return nil
    }

    /// The tool call payload, if this message contains a tool call.
    @objc public var toolCall: LiveServerToolCall? {
        if case .toolCall(let toolCall) = value.payload {
            return LiveServerToolCall(value: toolCall)
        }
        return nil
    }

    /// The tool call cancellation payload, if this message cancels a tool call.
    @objc public var toolCallCancellation: LiveServerToolCallCancellation? {
        if case .toolCallCancellation(let cancellation) = value.payload {
            return LiveServerToolCallCancellation(value: cancellation)
        }
        return nil
    }

    /// The session resumption update payload, if the server sent a resumption state update.
    @objc public var sessionResumptionUpdate: LiveSessionResumptionUpdate? {
        if case .sessionResumptionUpdate(let update) = value.payload {
            return LiveSessionResumptionUpdate(value: update)
        }
        return nil
    }

    /// The going-away notice payload, if the server is disconnecting.
    @objc public var goingAwayNotice: LiveServerGoingAwayNotice? {
        if case .goingAwayNotice(let notice) = value.payload {
            return LiveServerGoingAwayNotice(value: notice)
        }
        return nil
    }

    /// Token usage metadata for this message, if available.
    @objc public var usageMetadata: UsageMetadata? {
        return value.usageMetadata.map { UsageMetadata(value: $0) }
    }
}
