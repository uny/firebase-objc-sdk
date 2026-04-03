import Foundation
import Testing
@testable import FirebaseAILogicObjC

@Suite struct SchemaTests {
    @Test func stringSchema() {
        let schema = Schema.string(
            description: "A name",
            title: "Name",
            nullable: false,
            format: nil
        )
        #expect(schema.type == "STRING")
        #expect(schema.schemaDescription == "A name")
        #expect(schema.title == "Name")
        #expect(schema.nullable == false)
    }

    @Test func integerSchema() {
        let schema = Schema.integer(
            description: "Age",
            title: "age",
            nullable: true,
            format: "int32",
            minimum: 0,
            maximum: 150
        )
        #expect(schema.type == "INTEGER")
        #expect(schema.schemaDescription == "Age")
        #expect(schema.nullable == true)
        #expect(schema.minimum == 0)
        #expect(schema.maximum == 150)
    }

    @Test func booleanSchema() {
        let schema = Schema.boolean(
            description: "Active",
            title: nil,
            nullable: false
        )
        #expect(schema.type == "BOOLEAN")
        #expect(schema.schemaDescription == "Active")
        #expect(schema.nullable == false)
    }

    @Test func arraySchema() {
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
        #expect(schema.type == "ARRAY")
        #expect(schema.items != nil)
        #expect(schema.items?.type == "STRING")
        #expect(schema.minItems == 1)
        #expect(schema.maxItems == 10)
    }

    @Test func objectSchema() {
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
        #expect(schema.type == "OBJECT")
        #expect(schema.properties?["name"] != nil)
        #expect(schema.properties?["name"]?.type == "STRING")
        #expect(schema.propertyOrdering == ["name"])
    }

    @Test func enumerationSchema() {
        let schema = Schema.enumeration(
            values: ["red", "green", "blue"],
            description: "Color",
            title: nil,
            nullable: false
        )
        #expect(schema.type == "STRING")
        #expect(schema.enumValues == ["red", "green", "blue"])
    }

    @Test func anyOfSchema() {
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
        #expect(schema.anyOf?.count == 2)
        #expect(schema.anyOf?[0].type == "STRING")
        #expect(schema.anyOf?[1].type == "INTEGER")
    }
}
