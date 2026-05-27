import Foundation
import Testing
@testable import FirebaseAILogicObjC

@Suite struct TypeConversionTests {

    // MARK: - TextPart

    @Test func textPartRoundTrip() {
        let part = TextPart(text: "Hello, world!")
        #expect(part.text == "Hello, world!")
        #expect(!part.isThought)
    }

    // MARK: - InlineDataPart

    @Test func inlineDataPartRoundTrip() {
        let data = Data([0x01, 0x02, 0x03])
        let part = InlineDataPart(data: data, mimeType: "application/octet-stream")
        #expect(part.data == data)
        #expect(part.mimeType == "application/octet-stream")
    }

    // MARK: - FileDataPart

    @Test func fileDataPartRoundTrip() {
        let part = FileDataPart(uri: "gs://bucket/file.png", mimeType: "image/png")
        #expect(part.uri == "gs://bucket/file.png")
        #expect(part.mimeType == "image/png")
    }

    // MARK: - ModelContent

    @Test func modelContentFromText() {
        let content = ModelContent(text: "Test prompt")
        #expect(content.role == "user")
        #expect(content.parts.count == 1)
        let textPart = content.parts.first as? TextPart
        #expect(textPart != nil)
        #expect(textPart?.text == "Test prompt")
    }

    @Test func modelContentWithRole() {
        let content = ModelContent(role: "model", text: "Response")
        #expect(content.role == "model")
    }

    @Test func modelContentWithParts() {
        let text = TextPart(text: "Hello")
        let data = InlineDataPart(data: Data([0xFF]), mimeType: "image/png")
        let content = ModelContent(parts: [text, data])
        #expect(content.parts.count == 2)
        #expect(content.parts[0] is TextPart)
        #expect(content.parts[1] is InlineDataPart)
    }

    // MARK: - Backend

    @Test func backendFactoryMethods() {
        let googleAI = Backend.googleAI()
        #expect(googleAI != nil)

        let vertexAI = Backend.vertexAI()
        #expect(vertexAI != nil)

        let vertexAIWithLocation = Backend.vertexAI(location: "us-central1")
        #expect(vertexAIWithLocation != nil)
    }

    // MARK: - Schema

    @Test func schemaStringFactory() {
        let schema = Schema.string(description: "A name", title: "name", nullable: false, format: nil)
        #expect(schema.type == "STRING")
        #expect(schema.schemaDescription == "A name")
        #expect(schema.title == "name")
    }

    @Test func schemaBooleanFactory() {
        let schema = Schema.boolean(description: "Is active", title: "active", nullable: true)
        #expect(schema.type == "BOOLEAN")
        #expect(schema.nullable == NSNumber(value: true))
    }

    @Test func schemaIntegerFactory() {
        let schema = Schema.integer(
            description: "Age",
            title: "age",
            nullable: false,
            format: "int32",
            minimum: NSNumber(value: 0),
            maximum: NSNumber(value: 150)
        )
        #expect(schema.type == "INTEGER")
        #expect(schema.minimum == NSNumber(value: 0))
        #expect(schema.maximum == NSNumber(value: 150))
    }

    @Test func schemaFloatFactory() {
        let schema = Schema.float(
            description: "Score",
            title: nil,
            nullable: false,
            minimum: NSNumber(value: 0.0),
            maximum: NSNumber(value: 100.0)
        )
        #expect(schema.type == "NUMBER")
    }

    @Test func schemaDoubleFactory() {
        let schema = Schema.double(
            description: "Precise value",
            title: nil,
            nullable: false,
            minimum: nil,
            maximum: nil
        )
        #expect(schema.type == "NUMBER")
    }

    @Test func schemaEnumerationFactory() {
        let schema = Schema.enumeration(
            values: ["red", "green", "blue"],
            description: "Color",
            title: nil,
            nullable: false
        )
        #expect(schema.type == "STRING")
        #expect(schema.enumValues == ["red", "green", "blue"])
    }

    @Test func schemaArrayFactory() {
        let items = Schema.string(description: nil, title: nil, nullable: false, format: nil)
        let schema = Schema.array(
            items: items,
            description: "Tags",
            title: nil,
            nullable: false,
            minItems: NSNumber(value: 1),
            maxItems: NSNumber(value: 10)
        )
        #expect(schema.type == "ARRAY")
        #expect(schema.items != nil)
        #expect(schema.minItems == NSNumber(value: 1))
        #expect(schema.maxItems == NSNumber(value: 10))
    }

    @Test func schemaObjectFactory() {
        let nameSchema = Schema.string(description: nil, title: nil, nullable: false, format: nil)
        let schema = Schema.object(
            properties: ["name": nameSchema],
            optionalProperties: [],
            propertyOrdering: ["name"],
            description: "A person",
            title: "Person",
            nullable: false
        )
        #expect(schema.type == "OBJECT")
        #expect(schema.properties?["name"] != nil)
        #expect(schema.propertyOrdering == ["name"])
    }

    @Test func schemaAnyOfFactory() {
        let stringSchema = Schema.string(description: nil, title: nil, nullable: false, format: nil)
        let integerSchema = Schema.integer(description: nil, title: nil, nullable: false, format: nil, minimum: nil, maximum: nil)
        let schema = Schema.anyOf(schemas: [stringSchema, integerSchema])
        #expect(schema.anyOf != nil)
        #expect(schema.anyOf?.count == 2)
    }

    // MARK: - GenerationConfig

    @Test func generationConfigCreation() {
        let config = GenerationConfig(
            temperature: NSNumber(value: 0.7),
            topP: NSNumber(value: 0.9),
            topK: NSNumber(value: 40),
            candidateCount: NSNumber(value: 1),
            maxOutputTokens: NSNumber(value: 1024),
            presencePenalty: nil,
            frequencyPenalty: nil,
            stopSequences: ["END"],
            responseMIMEType: "application/json",
            responseSchema: nil,
            responseModalities: [ResponseModality.text],
            thinkingConfig: nil,
            imageConfig: nil
        )
        #expect(config != nil)
    }

    @Test func generationConfigReadProperties() {
        let schema = Schema.string(description: nil, title: nil, nullable: false, format: nil)
        let thinkingConfig = ThinkingConfig(thinkingBudget: NSNumber(value: 1024), includeThoughts: NSNumber(value: true))
        let config = GenerationConfig(
            temperature: NSNumber(value: 0.7),
            topP: NSNumber(value: 0.9),
            topK: NSNumber(value: 40),
            candidateCount: NSNumber(value: 2),
            maxOutputTokens: NSNumber(value: 1024),
            presencePenalty: NSNumber(value: 0.5),
            frequencyPenalty: NSNumber(value: 0.3),
            stopSequences: ["END", "STOP"],
            responseMIMEType: "application/json",
            responseSchema: schema,
            responseModalities: [ResponseModality.text],
            thinkingConfig: thinkingConfig,
            imageConfig: nil
        )

        #expect(config.temperature == NSNumber(value: 0.7))
        #expect(config.topP == NSNumber(value: 0.9))
        #expect(config.topK == NSNumber(value: 40))
        #expect(config.candidateCount == NSNumber(value: 2))
        #expect(config.maxOutputTokens == NSNumber(value: 1024))
        #expect(config.presencePenalty == NSNumber(value: 0.5))
        #expect(config.frequencyPenalty == NSNumber(value: 0.3))
        #expect(config.stopSequences == ["END", "STOP"])
        #expect(config.responseMIMEType == "application/json")
        #expect(config.responseSchema != nil)
        #expect(config.responseModalities?.count == 1)
        #expect(config.thinkingConfig != nil)
    }

    @Test func generationConfigWithImageConfig() {
        let imageConfig = ImageConfig(
            aspectRatio: ImageConfigAspectRatio.landscape16x9,
            imageSize: ImageConfigImageSize.size1K
        )
        let config = GenerationConfig(
            temperature: nil,
            topP: nil,
            topK: nil,
            candidateCount: nil,
            maxOutputTokens: nil,
            presencePenalty: nil,
            frequencyPenalty: nil,
            stopSequences: nil,
            responseMIMEType: nil,
            responseSchema: nil,
            responseModalities: nil,
            thinkingConfig: nil,
            imageConfig: imageConfig
        )
        #expect(config.imageConfig != nil)
    }

    @Test func generationConfigNilProperties() {
        let config = GenerationConfig(
            temperature: nil,
            topP: nil,
            topK: nil,
            candidateCount: nil,
            maxOutputTokens: nil,
            presencePenalty: nil,
            frequencyPenalty: nil,
            stopSequences: nil,
            responseMIMEType: nil,
            responseSchema: nil,
            responseModalities: nil,
            thinkingConfig: nil,
            imageConfig: nil
        )

        #expect(config.temperature == nil)
        #expect(config.topP == nil)
        #expect(config.topK == nil)
        #expect(config.candidateCount == nil)
        #expect(config.maxOutputTokens == nil)
        #expect(config.presencePenalty == nil)
        #expect(config.frequencyPenalty == nil)
        #expect(config.stopSequences == nil)
        #expect(config.responseMIMEType == nil)
        #expect(config.responseSchema == nil)
        #expect(config.responseModalities == nil)
        #expect(config.thinkingConfig == nil)
        #expect(config.imageConfig == nil)
    }

    // MARK: - ImageConfig

    @Test func imageConfigCreation() {
        let config = ImageConfig(
            aspectRatio: ImageConfigAspectRatio.landscape16x9,
            imageSize: nil
        )
        #expect(config != nil)
    }

    @Test func imageConfigNilParameters() {
        let config = ImageConfig(aspectRatio: nil, imageSize: nil)
        #expect(config != nil)
    }

    // MARK: - ContextWindowCompressionConfig

    @Test func slidingWindowCreation() {
        let sw = SlidingWindow(targetTokens: NSNumber(value: 4096))
        #expect(sw != nil)
    }

    @Test func slidingWindowNilTokens() {
        let sw = SlidingWindow(targetTokens: nil)
        #expect(sw != nil)
    }

    @Test func contextWindowCompressionConfigCreation() {
        let sw = SlidingWindow(targetTokens: NSNumber(value: 4096))
        let config = ContextWindowCompressionConfig(
            triggerTokens: NSNumber(value: 8192),
            slidingWindow: sw
        )
        #expect(config != nil)
    }

    @Test func contextWindowCompressionConfigNilParameters() {
        let config = ContextWindowCompressionConfig(triggerTokens: nil, slidingWindow: nil)
        #expect(config != nil)
    }

    // MARK: - SessionResumptionConfig

    @Test func sessionResumptionConfigDefault() {
        let config = SessionResumptionConfig()
        #expect(config != nil)
    }

    @Test func sessionResumptionConfigWithHandle() {
        let config = SessionResumptionConfig(handle: "test-handle-abc123")
        #expect(config != nil)
    }

    // MARK: - RetrievalConfig

    @Test func retrievalConfigWithLocation() {
        let config = RetrievalConfig(
            latitude: NSNumber(value: 35.6762),
            longitude: NSNumber(value: 139.6503),
            languageCode: "ja"
        )
        #expect(config != nil)
    }

    @Test func retrievalConfigNilLocation() {
        let config = RetrievalConfig(latitude: nil, longitude: nil, languageCode: nil)
        #expect(config != nil)
    }

    // MARK: - ToolConfig with RetrievalConfig

    @Test func toolConfigWithRetrievalConfig() {
        let retrievalConfig = RetrievalConfig(latitude: nil, longitude: nil, languageCode: "en")
        let toolConfig = ToolConfig(
            functionCallingConfig: nil,
            retrievalConfig: retrievalConfig
        )
        #expect(toolConfig != nil)
    }

    // MARK: - SafetySetting

    @Test func safetySettingCreation() {
        let setting = SafetySetting(
            harmCategory: HarmCategory.harassment,
            threshold: HarmBlockThreshold.blockMediumAndAbove
        )
        #expect(setting.harmCategory.rawValue == "HARM_CATEGORY_HARASSMENT")
    }

    // MARK: - RequestOptions

    @Test func requestOptionsCreation() {
        let options = RequestOptions(timeout: 30.0)
        #expect(options != nil)
    }
}
