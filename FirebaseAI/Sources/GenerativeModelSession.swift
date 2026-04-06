#if compiler(>=6.2)
import FirebaseAILogic
import Foundation

/// The response from a ``GenerativeModelSession`` `respond` call.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSessionResponse)
public final class SessionResponse: NSObject, @unchecked Sendable {
    /// The generated content as a string.
    @objc public let content: String

    /// The raw ``GenerateContentResponse`` from the model.
    @objc public let rawResponse: GenerateContentResponse

    init(content: String, rawResponse: GenerateContentResponse) {
        self.content = content
        self.rawResponse = rawResponse
        super.init()
    }
}

/// A stream of snapshots from a ``GenerativeModelSession`` streaming response.
///
/// Use ``next()`` to receive progressive snapshots as they arrive, or ``collect()`` to wait for the
/// complete response. The two methods read from independent paths inside the upstream stream and
/// may be used together: ``collect()`` returns the final accumulated response regardless of how
/// many snapshots ``next()`` has already consumed.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSessionResponseStream)
public final class SessionResponseStream: NSObject, @unchecked Sendable {
    private let stream: FirebaseAILogic.GenerativeModelSession.ResponseStream<String, String>
    private let iterator: LockedSnapshotIterator

    init(stream: FirebaseAILogic.GenerativeModelSession.ResponseStream<String, String>) {
        self.stream = stream
        // Construct the Box here (outside of the actor's isolation domain) so the upstream's
        // non-Sendable iterator never crosses an isolation boundary; only the @unchecked Sendable
        // Box reference is passed into the actor.
        self.iterator = LockedSnapshotIterator(box: LockedSnapshotIterator.Box(stream))
        super.init()
    }

    /// Returns the next snapshot of the streaming response, or `nil` when the stream is finished.
    ///
    /// Each snapshot contains the partially accumulated content up to that point in the stream.
    @objc public func next() async throws -> SessionResponse? {
        try await iterator.next()
    }

    /// Collects the entire streamed response into a single ``SessionResponse``.
    @objc public func collect() async throws -> SessionResponse {
        let response = try await stream.collect()
        return SessionResponse(
            content: response.content,
            rawResponse: GenerateContentResponse(value: response.rawResponse)
        )
    }
}

/// A serialized iterator over a ``FirebaseAILogic/GenerativeModelSession/ResponseStream``.
///
/// Mirrors the ``LockedAsyncIterator`` pattern: the upstream struct iterator is held inside a
/// reference-typed `Box`, and access is serialized through the actor. No work is performed until
/// ``next()`` is called, and the upstream iterator (along with its share of the upstream stream)
/// is released when this object is deallocated.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
private actor LockedSnapshotIterator {
    private let box: Box
    private var pendingContinuations: [CheckedContinuation<SessionResponse?, Error>] = []
    private var isReading = false
    private var finished = false

    fileprivate final class Box: @unchecked Sendable {
        var iterator: FirebaseAILogic.GenerativeModelSession
            .ResponseStream<String, String>.AsyncIterator

        init(_ stream: FirebaseAILogic.GenerativeModelSession.ResponseStream<String, String>) {
            self.iterator = stream.makeAsyncIterator()
        }

        func next() async throws -> SessionResponse? {
            guard let snapshot = try await iterator.next() else { return nil }
            return SessionResponse(
                content: snapshot.content,
                rawResponse: GenerateContentResponse(value: snapshot.rawResponse)
            )
        }
    }

    init(box: Box) {
        self.box = box
    }

    func next() async throws -> SessionResponse? {
        try await withCheckedThrowingContinuation { continuation in
            pendingContinuations.append(continuation)
            drainQueue()
        }
    }

    private func drainQueue() {
        guard !isReading, !pendingContinuations.isEmpty else { return }
        isReading = true
        let continuation = pendingContinuations.removeFirst()

        if finished {
            continuation.resume(returning: nil)
            isReading = false
            drainQueue()
            return
        }

        Task {
            do {
                let value = try await self.box.next()
                if value == nil { self.finished = true }
                continuation.resume(returning: value)
            } catch {
                self.finished = true
                continuation.resume(throwing: error)
                for pending in self.pendingContinuations {
                    pending.resume(throwing: error)
                }
                self.pendingContinuations.removeAll()
            }
            self.isReading = false
            self.drainQueue()
        }
    }
}

/// A session that manages multi-turn interactions with a generative model, maintaining conversation
/// history between requests.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerativeModelSession)
public final class GenerativeModelSession: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.GenerativeModelSession

    init(value: FirebaseAILogic.GenerativeModelSession) {
        self.value = value
        super.init()
    }

    /// Sends a text prompt and returns the generated response as a string.
    ///
    /// - Parameters:
    ///   - text: The text prompt to send to the model.
    ///   - options: An optional ``GenerationConfig`` to override the model's default generation
    ///     configuration.
    /// - Returns: A ``SessionResponse`` containing the generated string content.
    @objc public func respond(text: String, options: GenerationConfig?) async throws
        -> SessionResponse {
        let response = try await value.respond(to: text, options: options?.value)
        return SessionResponse(
            content: response.content,
            rawResponse: GenerateContentResponse(value: response.rawResponse)
        )
    }

    /// Sends content parts and returns the generated response as a string.
    ///
    /// Parts from all provided ``ModelContent`` items are extracted and flattened into a single
    /// prompt. Role information from individual items is not preserved.
    ///
    /// - Parameters:
    ///   - content: An array of ``ModelContent`` whose parts are combined into a single prompt.
    ///   - options: An optional ``GenerationConfig`` to override the model's default generation
    ///     configuration.
    /// - Returns: A ``SessionResponse`` containing the generated string content.
    @objc public func respond(content: [ModelContent], options: GenerationConfig?) async throws
        -> SessionResponse {
        let parts: [any FirebaseAILogic.PartsRepresentable] = content.flatMap { $0.value.parts }
        let response = try await value.respond(to: parts, options: options?.value)
        return SessionResponse(
            content: response.content,
            rawResponse: GenerateContentResponse(value: response.rawResponse)
        )
    }

    /// Streams the model's response to a text prompt.
    ///
    /// - Parameters:
    ///   - text: The text prompt to send to the model.
    ///   - options: An optional ``GenerationConfig`` to override the model's default generation
    ///     configuration.
    /// - Returns: A ``SessionResponseStream`` whose ``SessionResponseStream/next()`` method yields
    ///   progressive snapshots, or whose ``SessionResponseStream/collect()`` method returns the
    ///   complete response.
    @objc public func streamResponse(text: String, options: GenerationConfig?)
        -> SessionResponseStream {
        let stream = value.streamResponse(to: text, options: options?.value)
        return SessionResponseStream(stream: stream)
    }

    /// Streams the model's response to content parts.
    ///
    /// Parts from all provided ``ModelContent`` items are extracted and flattened into a single
    /// prompt. Role information from individual items is not preserved.
    ///
    /// - Parameters:
    ///   - content: An array of ``ModelContent`` whose parts are combined into a single prompt.
    ///   - options: An optional ``GenerationConfig`` to override the model's default generation
    ///     configuration.
    /// - Returns: A ``SessionResponseStream`` whose ``SessionResponseStream/next()`` method yields
    ///   progressive snapshots, or whose ``SessionResponseStream/collect()`` method returns the
    ///   complete response.
    @objc public func streamResponse(content: [ModelContent], options: GenerationConfig?)
        -> SessionResponseStream {
        let parts: [any FirebaseAILogic.PartsRepresentable] = content.flatMap { $0.value.parts }
        let stream = value.streamResponse(to: parts, options: options?.value)
        return SessionResponseStream(stream: stream)
    }
}
#endif // compiler(>=6.2)
