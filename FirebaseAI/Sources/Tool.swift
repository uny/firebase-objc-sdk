import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBTool)
public final class Tool: NSObject {
    let value: FirebaseAILogic.Tool

    init(value: FirebaseAILogic.Tool) {
        self.value = value
        super.init()
    }

    @objc public static func functionDeclarations(_ functionDeclarations: [FunctionDeclaration]) -> Tool {
        return Tool(value: FirebaseAILogic.Tool.functionDeclarations(
            functionDeclarations.map { $0.value }
        ))
    }

    @objc public static func googleSearch(_ googleSearch: GoogleSearch) -> Tool {
        return Tool(value: FirebaseAILogic.Tool.googleSearch(googleSearch.value))
    }

    @objc public static func googleSearchDefault() -> Tool {
        return Tool(value: FirebaseAILogic.Tool.googleSearch())
    }

    @objc public static func urlContext() -> Tool {
        return Tool(value: FirebaseAILogic.Tool.urlContext())
    }

    @objc public static func codeExecution() -> Tool {
        return Tool(value: FirebaseAILogic.Tool.codeExecution())
    }
}
