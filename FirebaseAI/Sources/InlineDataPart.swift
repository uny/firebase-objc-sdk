import FirebaseAILogic
import Foundation

/// A part containing inline binary data (e.g., images).
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBInlineDataPart)
public final class InlineDataPart: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.InlineDataPart

    init(value: FirebaseAILogic.InlineDataPart) {
        self.value = value
        super.init()
    }

    /// Creates an inline data part.
    /// - Parameters:
    ///   - data: The raw binary data.
    ///   - mimeType: The MIME type of the data (e.g., `"image/png"`).
    @objc public convenience init(data: Data, mimeType: String) {
        self.init(value: FirebaseAILogic.InlineDataPart(data: data, mimeType: mimeType))
    }

    /// The raw binary data.
    @objc public var data: Data {
        value.data
    }

    /// The MIME type of the data.
    @objc public var mimeType: String {
        value.mimeType
    }

    /// Whether this part is a model thought.
    @objc public var isThought: Bool {
        value.isThought
    }
}
