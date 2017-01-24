//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

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
        self.objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    /**
     Initializes `TypeBinding` object, using provided `type`.
     
     - Parameter type: An Type (conforming to `Injectable` protocol) of object which should be returned by `getObject(withInjector injector: Injecting) -> Any?` function.
     
     - Returns: An initialized `TypeBinding` object.
     */
    public init<T>(withType type: T.Type) where T: Injectable {
        self.objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    /**
     Initializes `TypeBinding` object, using provided `type`.
     
     - Parameter type: An Type (subclass of `NSObject`) of object which should be returned by `getObject(withInjector injector: Injecting) -> Any?` function.
     
     - Returns: An initialized `TypeBinding` object.
     */
    public init<T>(withType type: T.Type) where T: NSObject {
        self.objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    /**
     Initializes `TypeBinding` object, using provided `type`.
     
     - Parameter type: An Type (subclass of `NSObject`, conforming to `Injectable` protocol) of object which should be returned by `getObject(withInjector injector: Injecting) -> Any?` function.
     
     - Returns: An initialized `TypeBinding` object.
     */
    public init<T>(withType type: T.Type) where T: NSObject, T: Injectable {
        self.objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    /**
     Uses the `injector` to return an object of `type` provided during initialization of this binding.
     
     - Parameter injector: Injector which is used in the `objectCreationClosure` to provide object to return.
     
     - Returns: Object of `type` created using the `injector`, or nil.
     */
    func getObject(withInjector injector: Injecting) -> Any? {
        return self.objectCreationClosure(injector)
    }
}
