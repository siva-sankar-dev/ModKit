// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModKit",
    platforms: [
          .iOS(.v16),
          .macOS(.v13)
      ],
    products: [
        .library(
            name: "ModKit",
            targets: ["ModKit"]),
    ],
    targets: [
        .target(
            name: "ModKit"),
        .testTarget(
            name: "ModKitTests",
            dependencies: ["ModKit"]
        ),
    ]
)
