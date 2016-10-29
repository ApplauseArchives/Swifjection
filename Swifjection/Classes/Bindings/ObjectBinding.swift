//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

public class ObjectBinding: Binding {
    
    var object: AnyObject

    public init(withObject object: AnyObject) {
        self.object = object
    }
    
    public func getObject(withInjector injector: Injecting) -> AnyObject {
        return object
    }
    
}
