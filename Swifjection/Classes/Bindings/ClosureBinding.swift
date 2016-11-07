//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

public class ClosureBinding: Binding {
    
    var closure: ((Swifjector) -> Any)
    
    public init(withClosure closure: @escaping (Swifjector) -> Any) {
        self.closure = closure
    }
    
    public func getObject(withInjector injector: Swifjector) -> Any {
        return self.closure(injector)
    }
    
}
