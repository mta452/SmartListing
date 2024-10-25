// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SmartListing",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "SmartListing",
            targets: ["SmartListing"]
        ),
    ],
    targets: [
        .target(
            name: "SmartListing",
            path: "Sources"
        ),
        .testTarget(
            name: "SmartListingTests",
            dependencies: ["SmartListing"],
            path: "Tests"
        ),
    ]
)
