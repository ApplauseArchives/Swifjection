![img](./swifjection-logo.png)

# About

Welcome to **Swijection** -- lightweight and simplistic dependency injection framework written in Swift for Swift .

The main idea behind this project is to achieve DI for Swift objects that does not inherit from Objective-C classes.

# Installation

**Swifjection** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Swifjection"
```

# Tutorial

## Setting up injector

Swifjection comes with `Swifector` class which conforms to `Injecting` protocol and is the default injector for your application.

Our framework (for now) does not provide functionality to store default injector, we recommand to create one and store in your `AppDelegate` using our `SwifjectorFactory` -- helper class which detects if app is running specs and gives you option to setup spec injector (see **Tests setup**):

```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var injector: Swifjector?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let binding = Binding()
        [...]
        injector = SwifjectorFactory(bindings: bindings).injector
        [...]
        return true
    }
}
```

## Mapping objects for injector

As in any other DI framework you can to setup mapping for objects you would like to inject. Currently Swifjection supports:
* **closure to type mapping**
```swift
let bindings = Bindings()
let closure = { injector in
    let object = MyClass() // create your object
    object.setup() // do some additional setup
    return object
}
bindings.bind(closure: closure, toType: ClassConformingToProtocol.self)
```

* **instance to type mapping**

```swift
let bindings = Bindings()

let object = MyClass()
bindings.bind(object: object, toType: MyClass.self) // binding object to class
bindings.bind(object: object, toType: MyProtocol.self) // binding object to protocol

let structObject = MyStruct()
bindings.bind(object: structObject, toType: MyProtocol.self) // binding struct to protocol
```

* **type to type mapping**

```swift
let bindings = Bindings()
bindings.bind(type: MyClass.self, toType: MyProtocol.self) // binding class to protocol
```

* **singleton binding**

```swift
let bindings = Bindings()
bindings.bindSingleton(forType: MyClass.self) // binding class as singleton
```

When no instance is mapped in module, Swifjection *tries* to create a fresh instance if one of the condition is met:
- class inherits from `NSObject` - instance is created by calling `init`
- class or struct conforms to `Injectable` - instance is created by calling `init?(injector:)`

Othewrwise injector will return nil.

## Fetching dependencies

Each class or struct which can be injected and/or has dependencies to be injected should conform to `Injectable` protocol:

```swift
protocol Injectable {
    init?(injector: Injecting)
    func injectDependencies(injector: Injecting)
}
```

This way when your class or struct is created via injector (using `init?(injector:)`) shortly afterwards it receive `injectDependencies(injector:)` callback. This is the place where you want to fetch your dependencies from `injector`.

For example, let's assume you have two classes:

```swift
class Foo {
}

class Bar {
	var foo: Foo?
}
```

In order to inject `foo` property using `Swifjection` you need to change your code to following:

```swift
class Foo: Injectable {
    required convenience init(injector: Injecting) {				
        self.init()
    }
}

class Bar: Injectable {
    var foo: Foo?

    required convenience init(injector: Injecting) {				
        self.init()
    }

    func injectDependencies(injector: Injecting) {
        foo = injector.getObject(withType: Foo.self)
    }
}

```


## Test setup

The `SwifjectorFactory` helper class detects if app is running specs, and in such case doesn't create Swifjector instance. This is useful especialy in AppDelegate, where injector is set up, and spread across other objects. App delegate is initialized in unit tests, and regular injector would be created, and used. When `SwifjectorFactory` detect it's running unit tests, it won't create injector.


```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var injector: Swifjector?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let binding = Binding()
        [...]
        injector = SwifjectorFactory(bindings: bindings).injector // This will return nil during unit testing
        [...]
        return true
    }
}
```

## Testing

You can use Swifjection binding to replace real objects with mocks/fakes during unit testing.
To illustrate this in more detail, let's use two classes from the example above:

```swift
class Foo: Injectable {
    required convenience init(injector: Injecting) {				
        self.init()
    }
}

class Bar: Injectable {
    var foo: Foo?

    required convenience init(injector: Injecting) {				
        self.init()
    }

    func injectDependencies(injector: Injecting) {
        foo = injector.getObject(withType: Foo.self)
    }
}
```

If we'd like to test `Bar` class, we'd like to use mocked/faked `Foo`, rather than real instance, just to be sure it returns values we expect it to return. Let's add a fake `Foo` class:

```swift
class FakeFoo: Foo {
    // override any functions needed for testing
}
```

Now we can use it in tests:

```swift
let specBindings = Bindings()

let foo = FakeFoo()
specBindings.(object: foo, toType: Foo.self)

let injector = Swifjector(bindings: specBindings)

let barSUT = injector.getObject(withType: Bar.self)

// do the testing
```

# Authors

* [Łukasz Przytuła](mailto:lprzytula@applause.com)
* [Aleksander Zubala](mailto:azubala@applause.com)

# License

**Swifjection** is available under the MIT license. See the LICENSE file for more info.
