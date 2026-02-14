import XCTest
@testable import FirebaseAILogicObjC

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
final class TypeConversionTests: XCTestCase {

    // MARK: - TextPart

    func testTextPartRoundTrip() {
        let part = TextPart(text: "Hello, world!")
        XCTAssertEqual(part.text, "Hello, world!")
        XCTAssertFalse(part.isThought)
    }

    // MARK: - InlineDataPart

    func testInlineDataPartRoundTrip() {
        let data = Data([0x01, 0x02, 0x03])
        let part = InlineDataPart(data: data, mimeType: "application/octet-stream")
        XCTAssertEqual(part.data, data)
        XCTAssertEqual(part.mimeType, "application/octet-stream")
    }

    // MARK: - FileDataPart

    func testFileDataPartRoundTrip() {
        let part = FileDataPart(uri: "gs://bucket/file.png", mimeType: "image/png")
        XCTAssertEqual(part.uri, "gs://bucket/file.png")
        XCTAssertEqual(part.mimeType, "image/png")
    }

    // MARK: - ModelContent

    func testModelContentFromText() {
        let content = ModelContent(text: "Test prompt")
        XCTAssertEqual(content.role, "user")
        XCTAssertEqual(content.parts.count, 1)
        let textPart = content.parts.first as? TextPart
        XCTAssertNotNil(textPart)
        XCTAssertEqual(textPart?.text, "Test prompt")
    }

    func testModelContentWithRole() {
        let content = ModelContent(role: "model", text: "Response")
        XCTAssertEqual(content.role, "model")
    }

    func testModelContentWithParts() {
        let text = TextPart(text: "Hello")
        let data = InlineDataPart(data: Data([0xFF]), mimeType: "image/png")
        let content = ModelContent(parts: [text, data])
        XCTAssertEqual(content.parts.count, 2)
        XCTAssertTrue(content.parts[0] is TextPart)
        XCTAssertTrue(content.parts[1] is InlineDataPart)
    }

    // MARK: - Backend

    func testBackendFactoryMethods() {
        let googleAI = Backend.googleAI()
        XCTAssertNotNil(googleAI)

        let vertexAI = Backend.vertexAI()
        XCTAssertNotNil(vertexAI)

        let vertexAIWithLocation = Backend.vertexAI(location: "us-central1")
        XCTAssertNotNil(vertexAIWithLocation)
    }

    // MARK: - Schema

    func testSchemaStringFactory() {
        let schema = Schema.string(description: "A name", title: "name", nullable: false, format: nil)
        XCTAssertEqual(schema.type, "STRING")
        XCTAssertEqual(schema.schemaDescription, "A name")
        XCTAssertEqual(schema.title, "name")
    }

    func testSchemaBooleanFactory() {
        let schema = Schema.boolean(description: "Is active", title: "active", nullable: true)
        XCTAssertEqual(schema.type, "BOOLEAN")
        XCTAssertEqual(schema.nullable, NSNumber(value: true))
    }

    func testSchemaIntegerFactory() {
        let schema = Schema.integer(
            description: "Age",
            title: "age",
            nullable: false,
            format: "int32",
            minimum: NSNumber(value: 0),
            maximum: NSNumber(value: 150)
        )
        XCTAssertEqual(schema.type, "INTEGER")
        XCTAssertEqual(schema.minimum, NSNumber(value: 0))
        XCTAssertEqual(schema.maximum, NSNumber(value: 150))
    }

    func testSchemaFloatFactory() {
        let schema = Schema.float(
            description: "Score",
            title: nil,
            nullable: false,
            minimum: NSNumber(value: 0.0),
            maximum: NSNumber(value: 100.0)
        )
        XCTAssertEqual(schema.type, "NUMBER")
    }

    func testSchemaDoubleFactory() {
        let schema = Schema.double(
            description: "Precise value",
            title: nil,
            nullable: false,
            minimum: nil,
            maximum: nil
        )
        XCTAssertEqual(schema.type, "NUMBER")
    }

    func testSchemaEnumerationFactory() {
        let schema = Schema.enumeration(
            values: ["red", "green", "blue"],
            description: "Color",
            title: nil,
            nullable: false
        )
        XCTAssertEqual(schema.type, "STRING")
        XCTAssertEqual(schema.enumValues, ["red", "green", "blue"])
    }

    func testSchemaArrayFactory() {
        let items = Schema.string(description: nil, title: nil, nullable: false, format: nil)
        let schema = Schema.array(
            items: items,
            description: "Tags",
            title: nil,
            nullable: false,
            minItems: NSNumber(value: 1),
            maxItems: NSNumber(value: 10)
        )
        XCTAssertEqual(schema.type, "ARRAY")
        XCTAssertNotNil(schema.items)
        XCTAssertEqual(schema.minItems, NSNumber(value: 1))
        XCTAssertEqual(schema.maxItems, NSNumber(value: 10))
    }

    func testSchemaObjectFactory() {
        let nameSchema = Schema.string(description: nil, title: nil, nullable: false, format: nil)
        let schema = Schema.object(
            properties: ["name": nameSchema],
            optionalProperties: [],
            propertyOrdering: ["name"],
            description: "A person",
            title: "Person",
            nullable: false
        )
        XCTAssertEqual(schema.type, "OBJECT")
        XCTAssertNotNil(schema.properties?["name"])
        XCTAssertEqual(schema.propertyOrdering, ["name"])
    }

    func testSchemaAnyOfFactory() {
        let stringSchema = Schema.string(description: nil, title: nil, nullable: false, format: nil)
        let integerSchema = Schema.integer(description: nil, title: nil, nullable: false, format: nil, minimum: nil, maximum: nil)
        let schema = Schema.anyOf(schemas: [stringSchema, integerSchema])
        XCTAssertNotNil(schema.anyOf)
        XCTAssertEqual(schema.anyOf?.count, 2)
    }

    // MARK: - GenerationConfig

    func testGenerationConfigCreation() {
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
            thinkingConfig: nil
        )
        XCTAssertNotNil(config)
    }

    func testGenerationConfigReadProperties() {
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
            thinkingConfig: thinkingConfig
        )

        XCTAssertEqual(config.temperature, NSNumber(value: 0.7))
        XCTAssertEqual(config.topP, NSNumber(value: 0.9))
        XCTAssertEqual(config.topK, NSNumber(value: 40))
        XCTAssertEqual(config.candidateCount, NSNumber(value: 2))
        XCTAssertEqual(config.maxOutputTokens, NSNumber(value: 1024))
        XCTAssertEqual(config.presencePenalty, NSNumber(value: 0.5))
        XCTAssertEqual(config.frequencyPenalty, NSNumber(value: 0.3))
        XCTAssertEqual(config.stopSequences, ["END", "STOP"])
        XCTAssertEqual(config.responseMIMEType, "application/json")
        XCTAssertNotNil(config.responseSchema)
        XCTAssertEqual(config.responseModalities?.count, 1)
        XCTAssertNotNil(config.thinkingConfig)
    }

    func testGenerationConfigNilProperties() {
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
            thinkingConfig: nil
        )

        XCTAssertNil(config.temperature)
        XCTAssertNil(config.topP)
        XCTAssertNil(config.topK)
        XCTAssertNil(config.candidateCount)
        XCTAssertNil(config.maxOutputTokens)
        XCTAssertNil(config.presencePenalty)
        XCTAssertNil(config.frequencyPenalty)
        XCTAssertNil(config.stopSequences)
        XCTAssertNil(config.responseMIMEType)
        XCTAssertNil(config.responseSchema)
        XCTAssertNil(config.responseModalities)
        XCTAssertNil(config.thinkingConfig)
    }

    // MARK: - SafetySetting

    func testSafetySettingCreation() {
        let setting = SafetySetting(
            harmCategory: HarmCategory.harassment,
            threshold: HarmBlockThreshold.blockMediumAndAbove
        )
        XCTAssertEqual(setting.harmCategory.rawValue, "HARM_CATEGORY_HARASSMENT")
    }

    // MARK: - RequestOptions

    func testRequestOptionsCreation() {
        let options = RequestOptions(timeout: 30.0)
        XCTAssertNotNil(options)
    }
}
