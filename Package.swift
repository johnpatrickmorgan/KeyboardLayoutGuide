// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "KeyboardLayoutGuide",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "KeyboardLayoutGuide",
            targets: ["KeyboardLayoutGuide"]),
    ],
    dependencies: [
        .package(url: "https://github.com/johnpatrickmorgan/LifecycleHooks.git", from: "0.6.1")
    ],
    targets: [
        .target(
            name: "KeyboardLayoutGuide",
            dependencies: [],
            path: "Pod/Classes"
        )
    ]
)