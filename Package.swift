import PackageDescription

let package = Package(
  name: "Swifjection",
  exclude: [
    "Example",
    "_Pods.xcodeproj",
    "Sources/Swifjection/Assets",
    "Sources/Swifjection/Classes/SwifjectionIntegrationTests.swift",
    "Sources/Swifjection/Classes/SwifjectorSpec.swift",
    "Sources/Swifjection/Classes/Bindings/BindingsSpec.swift",
    "Sources/Swifjection/Classes/Bindings/ClosureBindingSpec.swift",
    "Sources/Swifjection/Classes/Bindings/ObjectBindingSpec.swift",
    "Sources/Swifjection/Classes/Bindings/SingletonBindingSpec.swift",
    "Sources/Swifjection/Classes/Bindings/TypeBindingSpec.swift"
  ]
)
