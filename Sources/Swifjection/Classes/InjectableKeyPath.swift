//
//  Copyright © 2019 Applause Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// Concrete implementation of `InjectableProperty`, designed to be used with `KeyPath`.

struct InjectableKeyPath<R>: InjectableProperty {
    /**
     Created during initialization of the object, used later in `inject(to:, with:)` function to inject the dependency into a property.
     */
    private let injectClosure: (R, Injecting) -> Void

    /**
     Initializes `InjectableKeyPath` object, using provided `keyPath`, which contains information about property to inject, and it's type, which can be `Optional<Any> type`.

     - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

     - Returns: An initialized `InjectableKeyPath` object.
     */
    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) where T: Any {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    /**
     Initializes `InjectableKeyPath` object, using provided `keyPath`, which contains information about property to inject, and it's type, which can be `Optional<NSObject> type`.

     - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

     - Returns: An initialized `InjectableKeyPath` object.
     */
    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) where T: NSObject {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    /**
     Initializes `InjectableKeyPath` object, using provided `keyPath`, which contains information about property to inject, and it's type, which can be `Optional<Creatable> type`.

     - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

     - Returns: An initialized `InjectableKeyPath` object.
     */
    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) where T: Creatable {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    /**
     Initializes `InjectableKeyPath` object, using provided `keyPath`, which contains information about property to inject, and it's type, which can be `Optional` of `NSObject` conforming to `Creatable` protocol.

     - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

     - Returns: An initialized `InjectableKeyPath` object.
     */
    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) where T: NSObject, T: Creatable {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    /**
     Initializes `InjectableKeyPath` object, using provided `keyPath`, which contains information about property to inject, and it's type, which can be `Any` type.

     - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

     - Returns: An initialized `InjectableKeyPath` object.
     */
    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, T>) where T: Any {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    /**
     Initializes `InjectableKeyPath` object, using provided `keyPath`, which contains information about property to inject, and it's type, which can be of `NSObject` type.

     - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

     - Returns: An initialized `InjectableKeyPath` object.
     */
    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, T>) where T: NSObject {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    /**
     Initializes `InjectableKeyPath` object, using provided `keyPath`, which contains information about property to inject, and it's type, which conforms to `Creatable` protocol.

     - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

     - Returns: An initialized `InjectableKeyPath` object.
     */
    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, T>) where T: Creatable {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    /**
     Initializes `InjectableKeyPath` object, using provided `keyPath`, which contains information about property to inject, and it's type, which can be `NSObject` conforming to `Creatable` protocol.

     - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

     - Returns: An initialized `InjectableKeyPath` object.
     */
    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, T>) where T: NSObject, T: Creatable {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    /**
     Creates an dependency objects and injects into `owner` object.

     Uses the `injectClosure` created during initialization, with `injector`, to create and inject a dependency object into the `owner` object.

     - Parameter owner: An object to which the dependency should be injected.

     - Parameter injector: An object used to inject inner dependency.
     */
    public func inject<T: AnyObject>(to owner: T, with injector: Injecting) {
        guard let castedOwner = owner as? R else {
            return
        }
        injectClosure(castedOwner, injector)
    }

}

/**
 Public function used to create `InjectableProperty` with a `ReferenceWritableKeyPath`, for a property of `Optional<Any> type.

 - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

 - Returns: An initialized `InjectableProperty`.
 */
public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) -> InjectableProperty where T: Any {
    return InjectableKeyPath(keyPath)
}

/**
 Public function used to create `InjectableProperty` with a `ReferenceWritableKeyPath`, for a property of `Optional<NSObject> type.

 - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

 - Returns: An initialized `InjectableProperty`.
 */
public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) -> InjectableProperty where T: NSObject {
    return InjectableKeyPath(keyPath)
}

/**
 Public function used to create `InjectableProperty` with a `ReferenceWritableKeyPath`, for a property of `Optional<Creatable> type.

 - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

 - Returns: An initialized `InjectableProperty`.
 */
public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) -> InjectableProperty where T: Creatable {
    return InjectableKeyPath(keyPath)
}

/**
 Public function used to create `InjectableProperty` with a `ReferenceWritableKeyPath`, for a property that is `Optional` of `NSObject` conforming to `Creatable` protocol.

 - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

 - Returns: An initialized `InjectableProperty`.
 */
public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) -> InjectableProperty where T: NSObject & Creatable {
    return InjectableKeyPath(keyPath)
}

/**
 Public function used to create `InjectableProperty` with a `ReferenceWritableKeyPath`, for a property of `Any` type.

 - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

 - Returns: An initialized `InjectableProperty`.
 */
public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, T>) -> InjectableProperty where T: Any {
    return InjectableKeyPath(keyPath)
}

/**
 Public function used to create `InjectableProperty` with a `ReferenceWritableKeyPath`, for a property of `NSObject` type.

 - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

 - Returns: An initialized `InjectableProperty`.
 */
public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, T>) -> InjectableProperty where T: NSObject {
    return InjectableKeyPath(keyPath)
}

/**
 Public function used to create `InjectableProperty` with a `ReferenceWritableKeyPath`, for a property of `Creatable` type.

 - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

 - Returns: An initialized `InjectableProperty`.
 */
public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, T>) -> InjectableProperty where T: Creatable {
    return InjectableKeyPath(keyPath)
}

/**
 Public function used to create `InjectableProperty` with a `ReferenceWritableKeyPath`, for a property that is `NSObject` conforming to `Creatable` protocol.

 - Parameter keyPath: Object containing information about the property to inject, owner type, and dependency type

 - Returns: An initialized `InjectableProperty`.
 */
public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, T>) -> InjectableProperty where T: NSObject & Creatable {
    return InjectableKeyPath(keyPath)
}
