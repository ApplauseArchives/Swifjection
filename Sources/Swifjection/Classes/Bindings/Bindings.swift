//
//  Copyright © 2017 Applause Inc. All rights reserved.
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

/// Groups all bindings for the injector, which uses it as a look up table when serving objects/structs.

open class Bindings {
    /**
     The `injector` used for creating new instances of objects in certain bindings.
     
     Injector will be passed to `getObject(withInjector injector: Injecting)` function.
     */
    weak var injector: Injecting?
    
    /**
     Dictionary of `Binding` objects bound to type names converted to `String`.
     */
    var bindings: [String: Binding] = [:]
    
    /**
     Initializes `Bindings` object.
     
     - Returns: An initialized `Bindings` object.
     */
    public init() { }
    
    /**
     Looks for the `Binding` assigned to provided `type`, and returns object returned by calling `getObject(withInjector injector: Injecting)`, or `nil` if no binding found.
     
     - Parameter type: Function will search for `Binding` object assigned to this `type`.
     
     - Returns: Object returned from binding, or `nil`.
     */
    public func findBinding(type: Any.Type) -> Any? {
        let typeName = "\(type)"
        if let injector = self.injector, let binding = bindings[typeName] {
            return binding.getObject(withInjector: injector)
        }
        return nil
    }

    /**
     Binds provided `object` using `ObjectBinding` to the `type`.
     
     - Parameter object: An instance that should be bound to provided `type`.
     - Parameter type: The `type` to which the `object` should be bound.
     */
    public func bind(object: Any, toType type: Any.Type) {
        let typeName = "\(type)"
        bindings[typeName] = ObjectBinding(withObject: object)
    }
    
    /**
     Binds provided `closure` using `ClosureBinding` to the `type`.
     
     - Parameter closure: A `closure` which should return an instance of provided `type` when called.
     - Parameter type: The `type` to which the `closure` should be bound.
     */
    public func bind(type: Any.Type, with closure: @escaping ((Injecting) -> Any)) {
        let typeName = "\(type)"
        bindings[typeName] = ClosureBinding(withClosure: closure)
    }
    
    /**
     Binds provided `type` in singleton scope using `SingletonBinding`.
     
     This function works properly with `Injectable` or `NSObject` types.
     In case when non `NSObject` and non `Injectable` `type` is bound as singleton, the binding will return `nil`.
     
     - Parameter type: The `type` which should be bound as singleton.
     */
    public func bindSingleton(forType type: Any.Type) {
        let typeName = "\(type)"
        bindings[typeName] = SingletonBinding(withType: type)
    }
    
    /**
     Binds provided `boundType` using `TypeBinding` to the `type`.
     
     When there is no other `Binding` bound to `boundType`, this function will return `nil`, as non `NSObject` and non `Injectable` type cannot be initialized.
     
     - Parameter boundType: Injector will look for another `Binding`, bound to `boundType` when asked for creating `type` object.
     - Parameter type: The `type` to which the `boundType` should be bound.
     
     - Returns: Instance of `boundType`, or nil.
     */
    public func bind<T>(type boundType: T.Type, toType type: Any.Type) {
        let typeName = "\(type)"
        bindings[typeName] = TypeBinding(withType: boundType)
    }
    
    /**
     Binds provided `boundType` using `TypeBinding` to the `type`.
     
     - Parameter boundType: Injector will try to initialize object of `boundType` when asked for creating `type` object.
     - Parameter type: The `type` to which the `boundType` should be bound.
     
     - Returns: Instance of `boundType`, or `nil`.
     */
    public func bind<T>(type boundType: T.Type, toType type: Any.Type) where T: Injectable {
        let typeName = "\(type)"
        bindings[typeName] = TypeBinding(withType: boundType)
    }
    
    /**
     Binds provided `boundType` using `TypeBinding` to the `type`.
     
     - Parameter boundType: Injector will try to initialize object of `boundType` when asked for creating `type` object.
     - Parameter type: The `type` to which the `boundType` should be bound.
     
     - Returns: Instance of `boundType`, or `nil`.
     */
    public func bind<T>(type boundType: T.Type, toType type: Any.Type) where T: NSObject {
        let typeName = "\(type)"
        bindings[typeName] = TypeBinding(withType: boundType)
    }
    
    /**
     Binds provided `boundType` using `TypeBinding` to the `type`.
     
     - Parameter boundType: Injector will try to initialize object of `boundType` when asked for creating `type` object.
     - Parameter type: The `type` to which the `boundType` should be bound.
     
     - Returns: Instance of `boundType`, or `nil`.
     */
    public func bind<T>(type boundType: T.Type, toType type: Any.Type) where T: NSObject, T: Injectable {
        let typeName = "\(type)"
        bindings[typeName] = TypeBinding(withType: boundType)
    }
}
