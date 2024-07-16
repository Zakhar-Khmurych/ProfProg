// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "practice3",
    products: [
        .library(
            name: "practice3",
            targets: ["practice3"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "practice3",
            dependencies: [],
            path: ".",
            sources: ["task_3_1_home.swift"]),
        .testTarget(
            name: "practice3Tests",
            dependencies: ["practice3"],
            path: ".",
            sources: ["task_31_home_test.swift"]),
    ]
)
