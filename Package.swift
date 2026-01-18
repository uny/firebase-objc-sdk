// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "firebase-objc-sdk",
    platforms: [.iOS(.v15), .macCatalyst(.v15), .macOS(.v10_15), .tvOS(.v15), .watchOS(.v7)],
    products: [
        .library(
            name: "FirebaseAILogicObjC",
            targets: ["FirebaseAILogicObjC"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.8.0"),
    ],
    targets: [
        .target(
            name: "FirebaseAILogicObjC",
            dependencies: [
                .product(name: "FirebaseAILogic", package: "firebase-ios-sdk"),
            ],
            path: "FirebaseAI/Sources",
        ),
    ]
)
