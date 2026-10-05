// swift-tools-version: 6.0
import PackageDescription

// Swift Package Manager manifest for the iOS sources the CocoaPods podspec
// ships (`source_files = "iOS/classes/**/*.{h,m,swift}", "iOS/RxBluetoothKit/**",
// "iOS/RxSwift/**"`). The single ObjC file is an empty marker class, so the
// manifest splits it from the pure-Swift body into a two-target library; no
// source changes are needed. RxSwift and RxBluetoothKit are vendored in-tree
// exactly as the podspec compiles them (Swift 5 language mode).
let package = Package(
    name: "MultiplatformBleAdapter",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MultiplatformBleAdapter",
            targets: ["MultiplatformBleAdapterKit", "MultiplatformBleAdapter"]
        ),
    ],
    targets: [
        .target(
            name: "MultiplatformBleAdapterKit",
            path: "iOS",
            exclude: [
                "MultiPlatformBLEAdapter-Bridging-Header.h",
                "MultiPlatformBLEAdapter.xcodeproj",
                "classes/MultiPlatformBLEAdapter.h",
                "classes/MultiPlatformBLEAdapter.m",
            ],
            sources: ["classes", "RxBluetoothKit", "RxSwift"],
            linkerSettings: [
                .linkedFramework("CoreBluetooth"),
                .linkedFramework("Foundation"),
            ]
        ),
        .target(
            name: "MultiplatformBleAdapter",
            dependencies: ["MultiplatformBleAdapterKit"],
            path: "iOS/classes",
            sources: ["MultiPlatformBLEAdapter.h", "MultiPlatformBLEAdapter.m"],
            publicHeadersPath: ".",
            linkerSettings: [
                .linkedFramework("CoreBluetooth"),
                .linkedFramework("Foundation"),
            ]
        ),
    ],
    swiftLanguageModes: [.v5]
)
