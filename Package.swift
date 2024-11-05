// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "AmeenSDK",
    platforms: [
            .iOS(.v17)  // Set the minimum supported iOS version to 16.0
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AmeenSDK",
            targets: ["AmeenSDK"]
        ),
        .library(
            name: "AmeenUI",
            targets: ["AmeenUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/elai950/AlertToast.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/SwiftUIX/SwiftUIX", .upToNextMajor(from: "0.1.5")),
        .package(url: "https://github.com/MessageKit/MessageKit", .upToNextMajor(from: "4.2.0")),
        .package(url: "https://github.com/simibac/ConfettiSwiftUI", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/MaximeFILIPPI/SnapPagerCarousel", .branch("main")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.12.0"))
    ],
    
    targets: [
        .target(
            name: "AmeenSDK",
            dependencies: [
                "AlertToast",
                "SwiftUIX",
                "MessageKit",
                "ConfettiSwiftUI",
                "SnapPagerCarousel",
                "Kingfisher"
            ]
        ),
        .target(
            name: "AmeenUI",
            dependencies: [
                "AlertToast",  // Add specific dependencies for AmeenUI
                "SwiftUIX",
                "ConfettiSwiftUI",
                "Kingfisher"
            ],
            resources: [
                .process("Fonts")  // Add Fonts folder containing custom font files
            ]
        ),
        .testTarget(
            name: "AmeenSDKTests",
            dependencies: ["AmeenSDK"]
        ),
        .testTarget(
            name: "AmeenUITests",
            dependencies: ["AmeenUI"]
        )
    ]
)