import PackageDescription

let package = Package(
    name: "Swiftmon",
    dependencies: [.Package(url: "git@github.com:ChrisChares/SKQueue.git", majorVersion: 1)]
)

