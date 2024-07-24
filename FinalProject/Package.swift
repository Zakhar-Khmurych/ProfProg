// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "FinalProject",
    products: [
        .library(
            name: "FinalProject",
            targets: ["FinalProject"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FinalProject",
            dependencies: []),
        .testTarget(
            name: "FinalProjectTests",
            dependencies: ["FinalProject"]),
    ]
)
