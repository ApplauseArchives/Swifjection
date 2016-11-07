![img](./swifjection-logo.png)

# About

Welcome to **Swijection** -- lightweight and simplistic dependency injection framework written in Swift for Swift . 

The main idea behind this project is to achieve DI for Swift objects that does not inherit from Objective-C classes. 

# Tutorial

## Setting up injector

Swifjection comes with protocol `Injecting` designeted for default injector in your application. Almost all protocol methods have implementation provided in provided extensions. The only thing you need to do is to create your own injector class, e.g. `DefaultInjector` and conform to `Injecting`:

```swift
class DefaultInjector: Injecting {}
```

Our framework (for now) does not provide functionality to store default injector, we recommand to create one and store in your `AppDelegate` using our `InjectorFactory` -- helper class which detects if app is running specs and gives you option to setup spec injector (see **Tests setup**):

```swift
//TODO example for creating injector
```

## Mapping objects for Injector

As in any other DI framework you can to setup mapping for objects you would like to inject. Currently Swifjection only supports **instance to type mapping**, which means that you create an intance and assign it to certain type -- sort of singleton type binding.

```swift
//TODO example of binding
```

When type is not mapped in module, Swifjection *tries* to create a fresh instance if one of the condition is met:
- class inherits from `NSObject` - instance is created by calling `init`
- class or struct conforms to `Injectable` - instance is created by calling `init?(injector:)` 

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
class Bar: Injectable {
	var foo: Foo?

	init?(injector: Injecting) {				
		self.init()
		foo = injector.createDependency(withType: Foo.self)
	}
}

```


## Test setup

## FAQ

# Installation

**Swifjection** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Swifjection"
````
# Authors

[Łukasz Przytuła](mailto:lprzytula@applause.com)
[Aleksander Zubala](mailto:azubala@applause.com)

# License

**Swifjection** is available under the MIT license. See the LICENSE file for more info.