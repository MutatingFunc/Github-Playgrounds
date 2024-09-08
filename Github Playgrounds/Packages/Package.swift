// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [
        .macCatalyst("17.0"),
        .iOS("17.0"),
        .tvOS("17.0"),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GithubAPI",
            targets: ["GithubAPI"]),
        .library(
            name: "GithubModels",
            targets: ["GithubModels"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", "1.14.0"..<"2.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GithubAPI",
            dependencies: [
                  .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
            ]
        ),
        .testTarget(
            name: "GithubAPITests",
            dependencies: ["GithubAPI"]),
        
        .target(
            name: "GithubModels",
            dependencies: [
                  .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                  "GithubAPI"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "GithubModelsTests",
            dependencies: ["GithubAPI", "GithubModels"]),
    ]
)
