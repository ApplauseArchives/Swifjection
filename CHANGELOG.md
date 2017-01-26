# Swifjection Changelog

## [Unreleased]
### Added:
* Continuous Integration setup with build status badge in README
* Code documentation
* Swift Package manifest
* CHANGELOG

### Changed:
* Changed order of closure binding function parameters:

  ```Swift
  func bind(closure: @escaping ((Injecting) -> Any), toType type: Any.Type)
  ```

  was renamed to

  ```Swift
  func bind(type: Any.Type, with closure: @escaping ((Injecting) -> Any))
  ```

  This allows to omit argument name and have closure defined after closing parenthesis. Instead of:

  ```Swift
  bindings.bind(closure: { (injector: Injecting) -> AnyObject in
    return SomeClass()
  }, toType: SomeClass.self)
  ```

  you can use:

  ```Swift
  bindings.bind(type: SomeClass.self) { (injector: Injecting) -> AnyObject in
    return SomeClass()
  }
  ```

## [0.5.0] - 18.01.2017 (Public release)
### Added:
* README with framework descripton and examples
* CONTRIBUTION document

## [0.4.1] - 22.12.2016
### Added:
* Updated object binding to allow binding struct objects

## [0.4.0] - 10.11.2016
### Added:
* Type to type binding
* Singleton binding

### Changed:
* Added bindings container object, conforming to `Binding` protocol, instead of keeping instances, or closures assigned directly to type

### Fixed:
* Changed bind functions `toType` parameter type from `Any` to `Any.Type`

## [0.3.1] - 28.10.2016
### Fixed:
* Bindings properties and functions access control

## [0.3.0] - 28.10.2016
### Added:
* `Swifjector` class implementing `Injecting` protocol

### Changed:
* Extracted binding from `Injecting` protocol to separate  `Bindings` class

## [0.2.0] - 28.10.2016 (First internal release)
### Added:
* Injectable protocol, and extension with default implementation of ```injectDependencies(injector: Injecting)``` function
* Injecting protocol, and extensions with default implementations of binding functions and creating dependencies functions
  - Object binding
  - Closure binding

[Unreleased]: https://github.com/ApplauseOSS/Swifjection/compare/0.5.0...HEAD
[0.5.0]: https://github.com/ApplauseOSS/Swifjection/compare/v0.4.1...0.5.0
[0.4.1]: https://github.com/ApplauseOSS/Swifjection/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/ApplauseOSS/Swifjection/compare/v0.3.1...v0.4.0
[0.3.1]: https://github.com/ApplauseOSS/Swifjection/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/ApplauseOSS/Swifjection/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/ApplauseOSS/Swifjection/tree/v0.2.0
