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

/// Describes a generic type which serves as `Creatable` types factory.

public protocol Injecting: class {
    /**
     Returns the `bindings` object provided to initializer.
     */
    var bindings: Bindings { get }
    
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
     getObject for type conforming to `Creatable` protocol, searches for an binding for provided `type` and returns it, or tries to create a new instance of provided `type` using `init()` method if nothing was bound.
     In case when `type` is a protocol, not a class, and nothing is bound to it, nil will be returned.
     
     - Parameter type: Type of the object to return.
     
     - Returns: Bound object of provided type, new instance, or nil.
     */
    func getObject<T>(withType type: T.Type) -> T? where T: Creatable

    /**
     getObject for type conforming to `InjectCreatable` protocol, searches for an binding for provided `type` and returns it, or tries to create a new instance of provided `type` using `init(injector: Injecting)` method if nothing was bound.
     
     - Parameter type: Type of the object to return.
     
     - Returns: Bound object of provided type, or new instance.
     */
    func getObject<T>(withType type: T.Type) -> T? where T: InjectCreatable

}
