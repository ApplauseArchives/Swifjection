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

/// Binds type to another type -- in most cases used for binding concrete class to a protocol. 

class TypeBinding: Binding {
    /**
     An closure created during initialization of binding, used to create instance of `type` provided during the initialization.
     */
    private var objectCreationClosure: ((Injecting) -> Any?)!
    
    /**
     Initializes `TypeBinding` object, using provided `type`.
     
     - Parameter type: An Type of object which should be returned by `getObject(withInjector injector: Injecting) -> Any?` function.
     
     - Returns: An initialized `TypeBinding` object.
     */
    public init<T>(withType type: T.Type) {
        objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    /**
     Initializes `TypeBinding` object, using provided `type`.
     
     - Parameter type: An Type (conforming to `Injectable` protocol) of object which should be returned by `getObject(withInjector injector: Injecting) -> Any?` function.
     
     - Returns: An initialized `TypeBinding` object.
     */
    public init<T>(withType type: T.Type) where T: Creatable {
        objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    /**
     Initializes `TypeBinding` object, using provided `type`.
     
     - Parameter type: An Type (subclass of `NSObject`) of object which should be returned by `getObject(withInjector injector: Injecting) -> Any?` function.
     
     - Returns: An initialized `TypeBinding` object.
     */
    public init<T>(withType type: T.Type) where T: NSObject {
        objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    /**
     Initializes `TypeBinding` object, using provided `type`.
     
     - Parameter type: An Type (subclass of `NSObject`, conforming to `Injectable` protocol) of object which should be returned by `getObject(withInjector injector: Injecting) -> Any?` function.
     
     - Returns: An initialized `TypeBinding` object.
     */
    public init<T>(withType type: T.Type) where T: NSObject, T: Creatable {
        objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    /**
     Uses the `injector` to return an object of `type` provided during initialization of this binding.
     
     - Parameter injector: Injector which is used in the `objectCreationClosure` to provide object to return.
     
     - Returns: Object of `type` created using the `injector`, or nil.
     */
    func getObject(withInjector injector: Injecting) -> Any? {
        return objectCreationClosure(injector)
    }
}
