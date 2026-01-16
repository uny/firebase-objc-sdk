# firebase-objc-sdk

![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)
![Platform](https://img.shields.io/badge/platform-iOS%2015%2B%20%7C%20macOS%2010.15%2B%20%7C%20tvOS%2015%2B%20%7C%20watchOS%207%2B-blue.svg)
![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)

An **Objective-C wrapper** for [FirebaseAILogic](https://github.com/firebase/firebase-ios-sdk) (Vertex AI in Firebase), designed specifically to be consumed by **Kotlin Multiplatform (KMP)** via cinterop.

## Why This Library Exists

Pure Swift libraries cannot be directly used in Kotlin Multiplatform cinterop. Swift's classes, generics, and async/await patterns are not compatible with the Objective-C runtime that Kotlin Native relies on for interoperability.

This library wraps Swift APIs into `NSObject` subclasses, making them accessible from Kotlin Native through cinterop. All public APIs are exposed as Objective-C-compatible classes with the `KFB` prefix.

## Requirements

- Swift 5.9+ / Xcode 15+
- iOS 15.0+
- macOS 10.15+
- Mac Catalyst 15.0+
- tvOS 15.0+
- watchOS 7.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/uny/firebase-objc-sdk.git", from: "0.1.0")
]
```

Then add `FirebaseAILogicObjC` to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "FirebaseAILogicObjC", package: "firebase-objc-sdk")
    ]
)
```

> **Note:** This library is typically not installed directly in an iOS app. Instead, it is added to your Kotlin Multiplatform project's Gradle setup or a local Swift package for cinterop.

## Usage

### Bridge Architecture

This library bridges Firebase AI from Swift to Kotlin through Objective-C:

```
Swift (FirebaseAILogic)  →  Objective-C (FirebaseAILogicObjC)  →  Kotlin Native (via cinterop)
     GenerativeModel     →       KFBGenerativeModel            →      GenerativeModel
     Content             →       KFBContent                    →      Content
     GenerateContentResponse →   KFBGenerateContentResponse    →      GenerateContentResponse
```

### Kotlin Example (Pseudo-code)

```kotlin
// In your KMP shared module, after setting up cinterop:
val firebaseAI = KFBFirebaseAI.vertexAI()
val model = firebaseAI.generativeModel(modelName = "gemini-2.0-flash")

val response = model.generateContent("Hello, how are you?")
println(response.text)
```

### Wrapped Classes

The library provides Objective-C wrappers for the following Firebase AI types:

- `KFBFirebaseAI` - Main entry point for Firebase AI
- `KFBGenerativeModel` - Generative model for content generation
- `KFBChat` - Chat session management
- `KFBContent` / `KFBContentBuilder` - Content building utilities
- `KFBGenerateContentResponse` - Response from content generation
- `KFBCandidate` - Response candidate
- `KFBModelContent` - Model content representation
- `KFBPart` / `KFBTextPart` / `KFBInlineDataPart` - Content parts
- `KFBCitation` / `KFBCitationMetadata` - Citation information
- `KFBGenerationConfig` - Generation configuration
- `KFBSafetyRating` / `KFBSafetySetting` - Safety controls
- And more...

## Versioning

| firebase-objc-sdk | firebase-ios-sdk |
|-------------------|------------------|
| 0.1.0             | 12.8.0           |

This library's version is independent of the underlying `firebase-ios-sdk` version. The table above shows which version of `firebase-ios-sdk` each release wraps.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
