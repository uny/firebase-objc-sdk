import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, *)
@available(watchOS, unavailable)
@objc(KFBLiveServerContent)
public final class LiveServerContent: NSObject {
    let value: FirebaseAILogic.LiveServerContent

    init(value: FirebaseAILogic.LiveServerContent) {
        self.value = value
        super.init()
    }

    @objc public var modelTurn: ModelContent? {
        return value.modelTurn.map { ModelContent(value: $0) }
    }

    @objc public var isTurnComplete: Bool {
        return value.isTurnComplete
    }

    @objc public var wasInterrupted: Bool {
        return value.wasInterrupted
    }

    @objc public var isGenerationComplete: Bool {
        return value.isGenerationComplete
    }
}
