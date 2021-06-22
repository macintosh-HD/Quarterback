// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Quarterback",
    products: [
        .library(
            name: "Quarterback",
            targets: ["Quarterback"]),
    ],
    targets: [
        .target(
            name: "Quarterback",
            dependencies: []),
        .testTarget(
            name: "QuarterbackTests",
            dependencies: ["Quarterback"]),
    ]
)
