//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import Foundation

public extension Injecting {
    public func getObject<T>(withType type: T.Type) -> T? where T: Any {
        if let object = bindings.findBinding(type: type) as? T {
            return object
        }
        return nil
    }
    
    public func getObject<T>(withType type: T.Type) -> T? where T: NSObject {
        if let object = bindings.findBinding(type: type) as? T {
            return object
        }
        return type.init()
    }
    
    public func getObject<T>(withType type: T.Type) -> T? where T: Injectable {
        if let object = bindings.findBinding(type: type) as? T {
            return object
        }
        if let object = type.init(injector: self) {
            object.injectDependencies(injector: self)
            return object
        }
        return nil
    }
    
    public func getObject<T>(withType type: T.Type) -> T? where T: NSObject, T: Injectable {
        if let object = bindings.findBinding(type: type) as? T {
            return object
        }
        if let object = type.init(injector: self) {
            object.injectDependencies(injector: self)
            return object
        }
        return nil
    }
}
