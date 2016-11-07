//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

public class ObjectBinding: Binding {
    
    var object: Any

    public init(withObject object: Any) {
        self.object = object
    }
    
    public func getObject(withInjector injector: Swifjector) -> Any {
        return object
    }
    
}
