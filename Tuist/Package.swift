// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [:],
        baseSettings: .settings(
            configurations: [
                .debug(name: "StagingDebug"),
                .debug(name: "ProductionDebug"),
                .release(name: "StagingRelease"),
                .release(name: "ProductionRelease"),
            ]
        ),
        targetSettings: [
            "FactoryKit": .settings(base: ["SWIFT_VERSION": "6.0"])
        ]
    )
#endif

let package = Package(
    name: "base_project",
    platforms: [.iOS(.v17)],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.3.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", exact: "4.0.0"),
        .package(url: "https://github.com/apple/swift-collections.git", exact: "1.0.4"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "11.5.0"),
        .package(url: "https://github.com/SVProgressHUD/SVProgressHUD.git", from: "2.2.5"),
        .package(path: "../Packages/Domain"),
        .package(path: "../Packages/Data"),
    ]
)
