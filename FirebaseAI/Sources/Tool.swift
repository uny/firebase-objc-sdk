import FirebaseAILogic
import Foundation

/// A tool that the model may use during generation.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBTool)
public final class Tool: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.Tool

    init(value: FirebaseAILogic.Tool) {
        self.value = value
        super.init()
    }

    /// Creates a tool with the given function declarations.
    /// - Parameter functionDeclarations: The functions the model may call.
    @objc public static func functionDeclarations(_ functionDeclarations: [FunctionDeclaration]) -> Tool {
        return Tool(value: FirebaseAILogic.Tool.functionDeclarations(
            functionDeclarations.map { $0.value }
        ))
    }

    /// Creates a tool backed by Google Search with a custom configuration.
    /// - Parameter googleSearch: The Google Search configuration.
    @objc public static func googleSearch(_ googleSearch: GoogleSearch) -> Tool {
        return Tool(value: FirebaseAILogic.Tool.googleSearch(googleSearch.value))
    }

    /// Creates a tool backed by Google Search with default configuration.
    @objc public static func googleSearchDefault() -> Tool {
        return Tool(value: FirebaseAILogic.Tool.googleSearch())
    }

    /// Creates a tool that provides URL context to the model.
    @objc public static func urlContext() -> Tool {
        return Tool(value: FirebaseAILogic.Tool.urlContext())
    }

    /// Creates a tool that enables code execution by the model.
    @objc public static func codeExecution() -> Tool {
        return Tool(value: FirebaseAILogic.Tool.codeExecution())
    }
}
