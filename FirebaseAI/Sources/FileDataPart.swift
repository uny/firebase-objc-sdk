import FirebaseAILogic
import Foundation

/// A part referencing a file by URI.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBFileDataPart)
public final class FileDataPart: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.FileDataPart

    init(value: FirebaseAILogic.FileDataPart) {
        self.value = value
        super.init()
    }

    /// Creates a file data part.
    /// - Parameters:
    ///   - uri: The URI of the file.
    ///   - mimeType: The MIME type of the file.
    @objc public convenience init(uri: String, mimeType: String) {
        self.init(value: FirebaseAILogic.FileDataPart(uri: uri, mimeType: mimeType))
    }

    /// The URI of the file.
    @objc public var uri: String {
        value.uri
    }

    /// The MIME type of the file.
    @objc public var mimeType: String {
        value.mimeType
    }

    /// Whether this part is a model thought.
    @objc public var isThought: Bool {
        value.isThought
    }
}
