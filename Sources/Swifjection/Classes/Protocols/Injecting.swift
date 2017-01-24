//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import Foundation

public protocol Injecting: class {
    /**
     Returns the `bindings` object provided to initializer.
     */
    var bindings: Bindings {get}
    
    /**
     Initializes injector object, using provided `bindings`, which contains information about instances, closures bound to types, or types bound in singleton scope.
     
     - Parameter bindings: Object containing information about instances, closures bound to types, or types bound in singleton scope
     
     - Returns: An initialized `Injecting` object.
     */
    init(bindings: Bindings)
    
    /**
     getObject for `Any` type searches for an object or closure bound to provided `type` and returns it, or nil if nothing was bound.
     
     - Parameter type: Type of the object to return.
     
     - Returns: Bound object of provided type, or nil.
     */
    func getObject<T>(withType type: T.Type) -> T? where T: Any
    
    /**
     getObject for `NSObject` subclass searches for an binding for provided `type` and returns it, or tries to create a new instance of provided `type` using `- (instancetype)init;` method if nothing was bound.
     
     - Parameter type: Type of the object to return.
     
     - Returns: Bound object of provided type, or new instance.
     */
    func getObject<T>(withType type: T.Type) -> T? where T: NSObject
    
    /**
     getObject for type conforming to `Injectable` protocol, searches for an binding for provided `type` and returns it, or tries to create a new instance of provided `type` using `init?(injector: Injecting)` method if nothing was bound.
     In case when `type` is a protocol, not a class, and nothing is bound to it, nil will be returned.
     
     - Parameter type: Type of the object to return.
     
     - Returns: Bound object of provided type, new instance, or nil.
     */
    func getObject<T>(withType type: T.Type) -> T? where T: Injectable
    
    /**
     getObject for `NSObject` subclass conforming to `Injectable` protocol, searches for an binding for provided `type` and returns it, or tries to create a new instance of provided `type` using `init?(injector: Injecting)` method if nothing was bound.
     
     - Parameter type: Type of the object to return.
     
     - Returns: Bound object of provided type, or new instance.
     */
    func getObject<T>(withType type: T.Type) -> T? where T: NSObject, T: Injectable
}
