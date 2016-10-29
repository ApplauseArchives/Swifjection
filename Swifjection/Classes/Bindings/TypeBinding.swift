//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

class TypeBinding: Binding {
    
    var objectCreationClosure: ((Injecting) -> Any?)!
    
    public init<T>(withType type: T.Type) {
        self.objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    public init<T>(withType type: T.Type) where T: Injectable {
        self.objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    public init<T>(withType type: T.Type) where T: NSObject {
        self.objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    public init<T>(withType type: T.Type) where T: NSObject, T: Injectable {
        self.objectCreationClosure = { injector in
            return injector.getObject(withType: type)
        }
    }
    
    func getObject(withInjector injector: Injecting) -> Any? {
        return self.objectCreationClosure(injector)
    }
    
}
