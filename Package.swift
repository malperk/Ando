// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Ando",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [.library(name: "Ando", targets: ["Ando"])],
    targets: [
        .target(name: "Ando", path: "Ando", exclude: ["Ando.h", "Info.plist"]),
        .testTarget(name: "AndoPackageTests", dependencies: ["Ando"], path: "Tests/AndoPackageTests")
    ]
)
