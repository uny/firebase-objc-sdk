import FirebaseAILogic
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBSchema)
public final class Schema: NSObject {
    let value: FirebaseAILogic.Schema

    init(value: FirebaseAILogic.Schema) {
        self.value = value
        super.init()
    }

    @objc public var type: String {
        return value.type
    }

    @objc public var format: String? {
        return value.format
    }

    @objc public var schemaDescription: String? {
        return value.description
    }

    @objc public var title: String? {
        return value.title
    }

    @objc public var nullable: NSNumber? {
        return value.nullable.map { NSNumber(value: $0) }
    }

    @objc public var enumValues: [String]? {
        return value.enumValues
    }

    @objc public var items: Schema? {
        return value.items.map { Schema(value: $0) }
    }

    @objc public var minItems: NSNumber? {
        return value.minItems.map { NSNumber(value: $0) }
    }

    @objc public var maxItems: NSNumber? {
        return value.maxItems.map { NSNumber(value: $0) }
    }

    @objc public var minimum: NSNumber? {
        return value.minimum.map { NSNumber(value: $0) }
    }

    @objc public var maximum: NSNumber? {
        return value.maximum.map { NSNumber(value: $0) }
    }

    @objc public var properties: [String: Schema]? {
        return value.properties?.mapValues { Schema(value: $0) }
    }

    @objc public var anyOf: [Schema]? {
        return value.anyOf?.map { Schema(value: $0) }
    }

    @objc public var requiredProperties: [String]? {
        return value.requiredProperties
    }

    @objc public var propertyOrdering: [String]? {
        return value.propertyOrdering
    }

    // MARK: - Factory Methods

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

    @objc public static func anyOf(schemas: [Schema]) -> Schema {
        return Schema(value: FirebaseAILogic.Schema.anyOf(schemas: schemas.map { $0.value }))
    }
}
