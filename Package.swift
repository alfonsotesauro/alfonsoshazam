// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlfonsosShazam",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "AlfonsosShazam",
            targets: ["AlfonsosShazam"])
    ],
    targets: [
        .executableTarget(
            name: "AlfonsosShazam",
            path: "Sources")
    ]
)
