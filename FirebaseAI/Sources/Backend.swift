import Foundation
import FirebaseAILogic

/// Specifies the backend AI provider (Google AI or Vertex AI).
@objc(KFBBackend)
public final class Backend: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.Backend

    init(value: FirebaseAILogic.Backend) {
        self.value = value
        super.init()
    }

    /// Creates a Google AI backend.
    @objc public static func googleAI() -> Backend {
        return Backend(value: .googleAI())
    }

    /// Creates a Vertex AI backend with the default location.
    @objc public static func vertexAI() -> Backend {
        return Backend(value: .vertexAI())
    }

    /// Creates a Vertex AI backend with a specific location.
    ///
    /// - Parameter location: The Google Cloud region to use (e.g., `"us-central1"`).
    @objc public static func vertexAI(location: String) -> Backend {
        return Backend(value: .vertexAI(location: location))
    }
}
