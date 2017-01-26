//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

/// Binds concrete instance of the object to given type.

public class ObjectBinding: Binding {
    /**
     Returns the `object` provided during initialization of binding.
     */
    var object: Any
    
    /**
     Initializes `ClosureBinding` object, using provided `object`.
     
     - Parameter object: An object of `Any` type, returned by `getObject` function.
     
     - Returns: An initialized `ObjectBinding` object.
     */
    public init(withObject object: Any) {
        self.object = object
    }
    
    /**
     - Parameter injector: The injector is not used in this binding.
     
     - Returns: Object provided during initialization of binding.
     */
    public func getObject(withInjector injector: Injecting) -> Any? {
        return object
    }
}
