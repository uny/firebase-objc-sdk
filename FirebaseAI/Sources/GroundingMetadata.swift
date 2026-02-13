import FirebaseAILogic
import Foundation

// MARK: - GroundingMetadata

/// Metadata about grounding sources used in generation.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGroundingMetadata)
public final class GroundingMetadata: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.GroundingMetadata

    init(value: FirebaseAILogic.GroundingMetadata) {
        self.value = value
        super.init()
    }

    /// The web search queries used for grounding.
    @objc public var webSearchQueries: [String] {
        value.webSearchQueries
    }

    /// The grounding chunks referenced in the generated content.
    @objc public var groundingChunks: [GroundingChunk] {
        value.groundingChunks.map { GroundingChunk(value: $0) }
    }

    /// Support information linking generated text to grounding chunks.
    @objc public var groundingSupports: [GroundingSupport] {
        value.groundingSupports.map { GroundingSupport(value: $0) }
    }

    /// The search entry point for web search results, if available.
    @objc public var searchEntryPoint: SearchEntryPoint? {
        value.searchEntryPoint.map { SearchEntryPoint(value: $0) }
    }
}

// MARK: - SearchEntryPoint

/// An entry point for a web search result.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSearchEntryPoint)
public final class SearchEntryPoint: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.GroundingMetadata.SearchEntryPoint

    init(value: FirebaseAILogic.GroundingMetadata.SearchEntryPoint) {
        self.value = value
        super.init()
    }

    /// The rendered HTML content for the search entry point.
    @objc public var renderedContent: String {
        value.renderedContent
    }
}

// MARK: - GroundingChunk

/// A chunk of grounding data.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGroundingChunk)
public final class GroundingChunk: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.GroundingMetadata.GroundingChunk

    init(value: FirebaseAILogic.GroundingMetadata.GroundingChunk) {
        self.value = value
        super.init()
    }

    /// The web grounding chunk, if this is a web-based source.
    @objc public var web: WebGroundingChunk? {
        value.web.map { WebGroundingChunk(value: $0) }
    }
}

// MARK: - WebGroundingChunk

/// A web-based grounding chunk with URL and title.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBWebGroundingChunk)
public final class WebGroundingChunk: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.GroundingMetadata.WebGroundingChunk

    init(value: FirebaseAILogic.GroundingMetadata.WebGroundingChunk) {
        self.value = value
        super.init()
    }

    /// The URI of the web source.
    @objc public var uri: String? {
        value.uri
    }

    /// The title of the web source.
    @objc public var title: String? {
        value.title
    }

    /// The domain of the web source.
    @objc public var domain: String? {
        value.domain
    }
}

// MARK: - GroundingSupport

/// Support information linking generated text to grounding sources.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGroundingSupport)
public final class GroundingSupport: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.GroundingMetadata.GroundingSupport

    init(value: FirebaseAILogic.GroundingMetadata.GroundingSupport) {
        self.value = value
        super.init()
    }

    /// The text segment that is supported by grounding sources.
    @objc public var segment: Segment {
        Segment(value: value.segment)
    }

    /// The indices of grounding chunks that support this segment.
    @objc public var groundingChunkIndices: [NSNumber] {
        value.groundingChunkIndices.map { NSNumber(value: $0) }
    }
}

// MARK: - Segment

/// A segment of generated text with position information.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSegment)
public final class Segment: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.Segment

    init(value: FirebaseAILogic.Segment) {
        self.value = value
        super.init()
    }

    /// The index of the part this segment belongs to.
    @objc public var partIndex: Int {
        value.partIndex
    }

    /// The start index of the segment in the generated text.
    @objc public var startIndex: Int {
        value.startIndex
    }

    /// The end index of the segment in the generated text.
    @objc public var endIndex: Int {
        value.endIndex
    }

    /// The text content of the segment.
    @objc public var text: String {
        value.text
    }
}
