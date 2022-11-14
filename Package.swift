// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "Masonry",
  platforms: [.iOS(.v9), .macOS(.v10_10), .watchOS(.v3), .tvOS(.v9)],
  products: ([
    [
      .library(name: "Masonry", targets: ["Masonry"]),
    ],
  ] as [[Product]]).flatMap { $0 },
  targets: ([
    [
        .target(
            name: "Masonry",
            dependencies: [],
            path: "Masonry",
            publicHeadersPath: "include"
        ),
    ], 
  ] as [[Target]]).flatMap { $0 }
)
