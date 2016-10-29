//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

public class SingletonBinding: Binding {
    
    var type: AnyObject.Type
    var instance: AnyObject?
    
    public init<T>(withType type: T.Type) where T: Injectable {
        self.type = type as! AnyObject.Type
    }
    
    public init<T>(withType type: T.Type) where T: NSObject {
        self.type = type
    }
    
    public init<T>(withType type: T.Type) where T: NSObject, T: Injectable {
        self.type = type
    }
    
    public func getObject(withInjector injector: Injecting) -> AnyObject {
        if self.instance == nil {
            if let type = self.type as? Injectable.Type {
                let instance = type.init(injector: injector)
                instance?.injectDependencies(injector: injector)
                self.instance = instance as AnyObject?
            } else if let type = self.type as? NSObject.Type {
                self.instance = type.init()
            }
        }
        return self.instance!
    }
    
}
