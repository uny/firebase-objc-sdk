# Firebase ObjC Wrapper Implementation Rules

You are an expert iOS/macOS developer assisting in creating an Objective-C wrapper (`firebase-objc-sdk`) for a Kotlin Multiplatform library (`firebase-kotlin-sdk`).
The goal is to wrap the pure Swift `FirebaseAILogic` (and related libraries) into `NSObject` subclasses that are exposed to Objective-C, allowing Kotlin Native to interact with them via cinterop.

## 1. Architectural Pattern

- **Wrapper Design**: Every public Swift class/struct in the source library must be wrapped in a `public class` inheriting from `NSObject`.
- **Value Holding**: The wrapper class must hold the original Swift object in a property named `value`.
- **Naming Convention**:
  - **Swift Class Name**: Same as the original class (e.g., `FirebaseAI`).
  - **Obj-C Name**: Use the prefix `KFB` (Kotlin Firebase) via `@objc(KFB...)`.
  - **Example**:
    ```swift
    @objc(KFBFirebaseAI)
    public class FirebaseAI: NSObject {
        let value: FirebaseAILogic.FirebaseAI
        // ...
    }
    ```

## 2. Implementation Details

### Initialization
- Provide an `init(value:)` that takes the underlying Swift object.
- If the original class has public initializers, reproduce them in the wrapper, delegating to the underlying initializer.

### Method Delegation
- Replicate all public methods and properties.
- **Parameters**:
  - Wrappers should accept wrapper types (e.g., `Backend`) and extract the `.value` to pass to the underlying call.
  - Basic types (String, Int, Bool) are passed directly.
- **Return Types**:
  - If the underlying method returns a Swift object, wrap it in its corresponding `KFB` wrapper before returning.
  - If it returns `Void` or basic types, return directly.

### Type Mapping
- **Structs**: Must be wrapped in a class inheriting from `NSObject` (same pattern as classes).
- **Enums**:
  - If simple `@objc` compatible enum: Expose directly or create a mirror `@objc` enum.
  - If complex Swift enum: Create a wrapper class or helper methods to bridge functionality.

### Async/Concurrency
- Preserve `async/await` signatures where possible (Kotlin Native supports Swift async).
- If completion handlers are used in the source, keep them.

## 3. Constraints & Requirements

- **Availability Attributes**:
  - strictly COPY the `@available` attributes from the original `firebase-ios-sdk` source code for every class and method.
  - Do not invent availability; use the source of truth.
  - Example: `@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)`

- **Default Arguments**:
  - **DO NOT** implement default values for arguments in Swift (e.g., `func foo(bar: Int = 0)`).
  - Kotlin code will handle default values. Define the full signature in Swift.

- **Imports**:
  - Import `Foundation`.
  - Import the underlying logic library (e.g., `FirebaseAILogic`).
  - Import `FirebaseCore` if generic Firebase types are needed.

## 4. Code Style Example

```swift
import FirebaseAILogic
import FirebaseCore
import Foundation

@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@objc(KFBGenerativeModel)
public class GenerativeModel: NSObject {
    let value: FirebaseAILogic.GenerativeModel

    init(value: FirebaseAILogic.GenerativeModel) {
        self.value = value
        super.init()
    }

    // Wrapper for a designated initializer
    @objc public convenience init(name: String, apiKey: String) {
        let model = FirebaseAILogic.GenerativeModel(name: name, apiKey: apiKey)
        self.init(value: model)
    }

    @objc public func generateContent(prompt: String) async throws -> GenerateContentResponse {
        let response = try await self.value.generateContent(prompt: prompt)
        return GenerateContentResponse(value: response)
    }
}
```
