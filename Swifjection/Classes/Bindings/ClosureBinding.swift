//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

public class ClosureBinding: Binding {
    
    var closure: ((Injecting) -> AnyObject)
    
    public init(withClosure closure: @escaping (Injecting) -> AnyObject) {
        self.closure = closure
    }
    
    public func getObject(withInjector injector: Injecting) -> AnyObject {
        return self.closure(injector)
    }
    
}
