//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

public class ClosureBinding: Binding {
    
    var closure: ((Injecting) -> Any)
    
    public init(withClosure closure: @escaping (Injecting) -> Any) {
        self.closure = closure
    }
    
    public func getObject(withInjector injector: Injecting) -> Any {
        return self.closure(injector)
    }
    
}
