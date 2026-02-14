import FirebaseAILogic
import Foundation

/// Represents a JSON Schema for structured output.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSchema)
public final class Schema: NSObject, @unchecked Sendable {
    let value: FirebaseAILogic.Schema

    init(value: FirebaseAILogic.Schema) {
        self.value = value
        super.init()
    }

    /// The data type of the schema (e.g., `"string"`, `"object"`).
    @objc public var type: String {
        return value.type
    }

    /// The format of the data, providing additional type hints.
    @objc public var format: String? {
        return value.format
    }

    /// A human-readable description of the schema.
    @objc public var schemaDescription: String? {
        return value.description
    }

    /// The title of the schema.
    @objc public var title: String? {
        return value.title
    }

    /// Whether the value can be `null`.
    @objc public var nullable: NSNumber? {
        return value.nullable.map { NSNumber(value: $0) }
    }

    /// The allowed values for an enumeration type.
    @objc public var enumValues: [String]? {
        return value.enumValues
    }

    /// The schema for items in an array type.
    @objc public var items: Schema? {
        return value.items.map { Schema(value: $0) }
    }

    /// The minimum number of items for an array type.
    @objc public var minItems: NSNumber? {
        return value.minItems.map { NSNumber(value: $0) }
    }

    /// The maximum number of items for an array type.
    @objc public var maxItems: NSNumber? {
        return value.maxItems.map { NSNumber(value: $0) }
    }

    /// The minimum value for a numeric type.
    @objc public var minimum: NSNumber? {
        return value.minimum.map { NSNumber(value: $0) }
    }

    /// The maximum value for a numeric type.
    @objc public var maximum: NSNumber? {
        return value.maximum.map { NSNumber(value: $0) }
    }

    /// The property schemas for an object type, keyed by property name.
    @objc public var properties: [String: Schema]? {
        return value.properties?.mapValues { Schema(value: $0) }
    }

    /// The schemas that the value must match at least one of.
    @objc public var anyOf: [Schema]? {
        return value.anyOf?.map { Schema(value: $0) }
    }

    /// The list of required property names for an object type.
    @objc public var requiredProperties: [String]? {
        return value.requiredProperties
    }

    /// The preferred ordering of properties for an object type.
    @objc public var propertyOrdering: [String]? {
        return value.propertyOrdering
    }

    // MARK: - Factory Methods

    /// Creates a schema for a string value.
    ///
    /// - Parameters:
    ///   - description: A human-readable description of the value.
    ///   - title: The title of the schema.
    ///   - nullable: Whether the value can be `null`.
    ///   - format: An optional format hint (e.g., `"date-time"`, `"uri"`).
    @objc public static func string(
        description: String?,
        title: String?,
        nullable: Bool,
        format: String?
    ) -> Schema {
        let formatValue = format.map { FirebaseAILogic.Schema.StringFormat.custom($0) }
        return Schema(value: FirebaseAILogic.Schema.string(
            description: description,
            title: title,
            nullable: nullable,
            format: formatValue
        ))
    }

    /// Creates a schema for an enumeration (a string constrained to specific values).
    ///
    /// - Parameters:
    ///   - values: The allowed enumeration values.
    ///   - description: A human-readable description of the value.
    ///   - title: The title of the schema.
    ///   - nullable: Whether the value can be `null`.
    @objc public static func enumeration(
        values: [String],
        description: String?,
        title: String?,
        nullable: Bool
    ) -> Schema {
        return Schema(value: FirebaseAILogic.Schema.enumeration(
            values: values,
            description: description,
            title: title,
            nullable: nullable
        ))
    }

    /// Creates a schema for a float value.
    ///
    /// - Parameters:
    ///   - description: A human-readable description of the value.
    ///   - title: The title of the schema.
    ///   - nullable: Whether the value can be `null`.
    ///   - minimum: The minimum allowed value, or `nil` for no lower bound.
    ///   - maximum: The maximum allowed value, or `nil` for no upper bound.
    @objc public static func float(
        description: String?,
        title: String?,
        nullable: Bool,
        minimum: NSNumber?,
        maximum: NSNumber?
    ) -> Schema {
        return Schema(value: FirebaseAILogic.Schema.float(
            description: description,
            title: title,
            nullable: nullable,
            minimum: minimum?.floatValue,
            maximum: maximum?.floatValue
        ))
    }

    /// Creates a schema for a double value.
    ///
    /// - Parameters:
    ///   - description: A human-readable description of the value.
    ///   - title: The title of the schema.
    ///   - nullable: Whether the value can be `null`.
    ///   - minimum: The minimum allowed value, or `nil` for no lower bound.
    ///   - maximum: The maximum allowed value, or `nil` for no upper bound.
    @objc public static func double(
        description: String?,
        title: String?,
        nullable: Bool,
        minimum: NSNumber?,
        maximum: NSNumber?
    ) -> Schema {
        return Schema(value: FirebaseAILogic.Schema.double(
            description: description,
            title: title,
            nullable: nullable,
            minimum: minimum?.doubleValue,
            maximum: maximum?.doubleValue
        ))
    }

    /// Creates a schema for an integer value.
    ///
    /// - Parameters:
    ///   - description: A human-readable description of the value.
    ///   - title: The title of the schema.
    ///   - nullable: Whether the value can be `null`.
    ///   - format: The integer format (`"int32"`, `"int64"`, or a custom format), or `nil`.
    ///   - minimum: The minimum allowed value, or `nil` for no lower bound.
    ///   - maximum: The maximum allowed value, or `nil` for no upper bound.
    @objc public static func integer(
        description: String?,
        title: String?,
        nullable: Bool,
        format: String?,
        minimum: NSNumber?,
        maximum: NSNumber?
    ) -> Schema {
        var formatValue: FirebaseAILogic.Schema.IntegerFormat?
        if let format = format {
            switch format {
            case "int32":
                formatValue = .int32
            case "int64":
                formatValue = .int64
            default:
                formatValue = .custom(format)
            }
        }
        return Schema(value: FirebaseAILogic.Schema.integer(
            description: description,
            title: title,
            nullable: nullable,
            format: formatValue,
            minimum: minimum?.intValue,
            maximum: maximum?.intValue
        ))
    }

    /// Creates a schema for a boolean value.
    ///
    /// - Parameters:
    ///   - description: A human-readable description of the value.
    ///   - title: The title of the schema.
    ///   - nullable: Whether the value can be `null`.
    @objc public static func boolean(
        description: String?,
        title: String?,
        nullable: Bool
    ) -> Schema {
        return Schema(value: FirebaseAILogic.Schema.boolean(
            description: description,
            title: title,
            nullable: nullable
        ))
    }

    /// Creates a schema for an array of values.
    ///
    /// - Parameters:
    ///   - items: The schema describing each item in the array.
    ///   - description: A human-readable description of the value.
    ///   - title: The title of the schema.
    ///   - nullable: Whether the value can be `null`.
    ///   - minItems: The minimum number of items, or `nil` for no minimum.
    ///   - maxItems: The maximum number of items, or `nil` for no maximum.
    @objc public static func array(
        items: Schema,
        description: String?,
        title: String?,
        nullable: Bool,
        minItems: NSNumber?,
        maxItems: NSNumber?
    ) -> Schema {
        return Schema(value: FirebaseAILogic.Schema.array(
            items: items.value,
            description: description,
            title: title,
            nullable: nullable,
            minItems: minItems?.intValue,
            maxItems: maxItems?.intValue
        ))
    }

    /// Creates a schema for an object with named properties.
    ///
    /// - Parameters:
    ///   - properties: A dictionary mapping property names to their schemas.
    ///   - optionalProperties: Property names that are not required.
    ///   - propertyOrdering: The preferred ordering of properties, or `nil`.
    ///   - description: A human-readable description of the value.
    ///   - title: The title of the schema.
    ///   - nullable: Whether the value can be `null`.
    @objc public static func object(
        properties: [String: Schema],
        optionalProperties: [String],
        propertyOrdering: [String]?,
        description: String?,
        title: String?,
        nullable: Bool
    ) -> Schema {
        return Schema(value: FirebaseAILogic.Schema.object(
            properties: properties.mapValues { $0.value },
            optionalProperties: optionalProperties,
            propertyOrdering: propertyOrdering,
            description: description,
            title: title,
            nullable: nullable
        ))
    }

    /// Creates a schema that matches any of the provided schemas.
    ///
    /// - Parameter schemas: The schemas the value may match.
    @objc public static func anyOf(schemas: [Schema]) -> Schema {
        return Schema(value: FirebaseAILogic.Schema.anyOf(schemas: schemas.map { $0.value }))
    }
}
