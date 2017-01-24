import PackageDescription

let package = Package(
    name: "Swifjection",
    exclude: [
       "Example",
       "_Pods.xcodeproj",
       "Swifjection/Classes/SwifjectionIntegrationTests.swift", 
	    "Swifjection/Classes/SwifjectorSpec.swift",
	    "Swifjection/Classes/Bindings/BindingsSpec.swift",
	    "Swifjection/Classes/Bindings/ClosureBindingSpec.swift",
	    "Swifjection/Classes/Bindings/ObjectBindingSpec.swift",
	    "Swifjection/Classes/Bindings/SingletonBindingSpec.swift",
	    "Swifjection/Classes/Bindings/TypeBindingSpec.swift"
	 ]
)
