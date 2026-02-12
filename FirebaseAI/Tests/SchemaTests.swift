import XCTest
@testable import FirebaseAILogicObjC

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
final class SchemaTests: XCTestCase {
    func testStringSchema() {
        let schema = Schema.string(
            description: "A name",
            title: "Name",
            nullable: false,
            format: nil
        )
        XCTAssertEqual(schema.type, "STRING")
        XCTAssertEqual(schema.schemaDescription, "A name")
        XCTAssertEqual(schema.title, "Name")
        XCTAssertEqual(schema.nullable, false)
    }

    func testIntegerSchema() {
        let schema = Schema.integer(
            description: "Age",
            title: "age",
            nullable: true,
            format: "int32",
            minimum: 0,
            maximum: 150
        )
        XCTAssertEqual(schema.type, "INTEGER")
        XCTAssertEqual(schema.schemaDescription, "Age")
        XCTAssertEqual(schema.nullable, true)
        XCTAssertEqual(schema.minimum, 0)
        XCTAssertEqual(schema.maximum, 150)
    }

    func testBooleanSchema() {
        let schema = Schema.boolean(
            description: "Active",
            title: nil,
            nullable: false
        )
        XCTAssertEqual(schema.type, "BOOLEAN")
        XCTAssertEqual(schema.schemaDescription, "Active")
        XCTAssertEqual(schema.nullable, false)
    }

    func testArraySchema() {
        let itemSchema = Schema.string(
            description: nil,
            title: nil,
            nullable: false,
            format: nil
        )
        let schema = Schema.array(
            items: itemSchema,
            description: "Tags",
            title: nil,
            nullable: false,
            minItems: 1,
            maxItems: 10
        )
        XCTAssertEqual(schema.type, "ARRAY")
        XCTAssertNotNil(schema.items)
        XCTAssertEqual(schema.items?.type, "STRING")
        XCTAssertEqual(schema.minItems, 1)
        XCTAssertEqual(schema.maxItems, 10)
    }

    func testObjectSchema() {
        let nameSchema = Schema.string(
            description: nil,
            title: nil,
            nullable: false,
            format: nil
        )
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
        XCTAssertEqual(schema.properties?["name"]?.type, "STRING")
        XCTAssertEqual(schema.propertyOrdering, ["name"])
    }

    func testEnumerationSchema() {
        let schema = Schema.enumeration(
            values: ["red", "green", "blue"],
            description: "Color",
            title: nil,
            nullable: false
        )
        XCTAssertEqual(schema.type, "STRING")
        XCTAssertEqual(schema.enumValues, ["red", "green", "blue"])
    }

    func testAnyOfSchema() {
        let stringSchema = Schema.string(
            description: nil,
            title: nil,
            nullable: false,
            format: nil
        )
        let intSchema = Schema.integer(
            description: nil,
            title: nil,
            nullable: false,
            format: nil,
            minimum: nil,
            maximum: nil
        )
        let schema = Schema.anyOf(schemas: [stringSchema, intSchema])
        XCTAssertEqual(schema.anyOf?.count, 2)
        XCTAssertEqual(schema.anyOf?[0].type, "STRING")
        XCTAssertEqual(schema.anyOf?[1].type, "INTEGER")
    }
}
