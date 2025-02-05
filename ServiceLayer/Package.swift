// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "ServiceLayer",
    platforms: [
        .iOS(.v15),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "ServiceLayer",
            targets: ["ServiceLayer"]),
        .library(
            name: "ServiceLayerMocks",
            targets: ["ServiceLayerMocks"])
    ],
    dependencies: [
        .package(url: "https://github.com/groue/CombineExpectations.git", .upToNextMajor(from: "0.7.0")),
        .package(url: "https://github.com/metabolist/codable-bloom-filter.git", .upToNextMajor(from: "1.0.0")),
        .package(path: "AppUrls"),
        .package(path: "DB"),
        .package(path: "Keychain"),
        .package(path: "MastodonAPI"),
        .package(path: "Secrets")
    ],
    targets: [
        .target(
            name: "ServiceLayer",
            dependencies: [
                "AppUrls",
                "DB",
                "MastodonAPI",
                "Secrets",
                .product(name: "CodableBloomFilter", package: "codable-bloom-filter")],
            resources: [.process("Resources")]),
        .target(
            name: "ServiceLayerMocks",
            dependencies: [
                "ServiceLayer",
                .product(name: "MastodonAPIStubs", package: "MastodonAPI"),
                .product(name: "MockKeychain", package: "Keychain")]),
        .testTarget(
            name: "ServiceLayerTests",
            dependencies: ["CombineExpectations", "ServiceLayerMocks"])
    ]
)
