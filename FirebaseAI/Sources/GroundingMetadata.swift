import FirebaseAILogic
import Foundation

// MARK: - GroundingMetadata

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGroundingMetadata)
public final class GroundingMetadata: NSObject {
    let value: FirebaseAILogic.GroundingMetadata

    init(value: FirebaseAILogic.GroundingMetadata) {
        self.value = value
        super.init()
    }

    @objc public var webSearchQueries: [String] {
        value.webSearchQueries
    }

    @objc public var groundingChunks: [GroundingChunk] {
        value.groundingChunks.map { GroundingChunk(value: $0) }
    }

    @objc public var groundingSupports: [GroundingSupport] {
        value.groundingSupports.map { GroundingSupport(value: $0) }
    }

    @objc public var searchEntryPoint: SearchEntryPoint? {
        value.searchEntryPoint.map { SearchEntryPoint(value: $0) }
    }
}

// MARK: - SearchEntryPoint

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSearchEntryPoint)
public final class SearchEntryPoint: NSObject {
    let value: FirebaseAILogic.GroundingMetadata.SearchEntryPoint

    init(value: FirebaseAILogic.GroundingMetadata.SearchEntryPoint) {
        self.value = value
        super.init()
    }

    @objc public var renderedContent: String {
        value.renderedContent
    }
}

// MARK: - GroundingChunk

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGroundingChunk)
public final class GroundingChunk: NSObject {
    let value: FirebaseAILogic.GroundingMetadata.GroundingChunk

    init(value: FirebaseAILogic.GroundingMetadata.GroundingChunk) {
        self.value = value
        super.init()
    }

    @objc public var web: WebGroundingChunk? {
        value.web.map { WebGroundingChunk(value: $0) }
    }
}

// MARK: - WebGroundingChunk

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBWebGroundingChunk)
public final class WebGroundingChunk: NSObject {
    let value: FirebaseAILogic.GroundingMetadata.WebGroundingChunk

    init(value: FirebaseAILogic.GroundingMetadata.WebGroundingChunk) {
        self.value = value
        super.init()
    }

    @objc public var uri: String? {
        value.uri
    }

    @objc public var title: String? {
        value.title
    }

    @objc public var domain: String? {
        value.domain
    }
}

// MARK: - GroundingSupport

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGroundingSupport)
public final class GroundingSupport: NSObject {
    let value: FirebaseAILogic.GroundingMetadata.GroundingSupport

    init(value: FirebaseAILogic.GroundingMetadata.GroundingSupport) {
        self.value = value
        super.init()
    }

    @objc public var segment: Segment {
        Segment(value: value.segment)
    }

    @objc public var groundingChunkIndices: [NSNumber] {
        value.groundingChunkIndices.map { NSNumber(value: $0) }
    }
}

// MARK: - Segment

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSegment)
public final class Segment: NSObject {
    let value: FirebaseAILogic.Segment

    init(value: FirebaseAILogic.Segment) {
        self.value = value
        super.init()
    }

    @objc public var partIndex: Int {
        value.partIndex
    }

    @objc public var startIndex: Int {
        value.startIndex
    }

    @objc public var endIndex: Int {
        value.endIndex
    }

    @objc public var text: String {
        value.text
    }
}
