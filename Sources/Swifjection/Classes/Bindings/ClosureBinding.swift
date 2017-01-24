//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

public class ClosureBinding: Binding {
    /**
     Returns the `closure` provided during initialization of binding.
     
     Injector will be passed when calling the `closure` and can be used to create returned object.
     */
    var closure: ((Injecting) -> Any)
    
    /**
     Initializes `ClosureBinding` object, using provided `closure`.
     
     - Parameter closure: An closure used by `getObject` function to return some object.
     
     - Returns: An initialized `ClosureBinding` object.
     */
    public init(withClosure closure: @escaping (Injecting) -> Any) {
        self.closure = closure
    }
    
    /**
     Uses the `closure` provided during initialization, to return an object.
     
     - Parameter injector: Injector which can be used in the closure to provide object to return.
     
     - Returns: Object created using the `closure`.
     */
    public func getObject(withInjector injector: Injecting) -> Any? {
        return self.closure(injector)
    }    
}
