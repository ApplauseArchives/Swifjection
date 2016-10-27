//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

extension Injecting {

    public func getObject<T>(withType type: T.Type) -> T? {
        if let object = findBinding(type: type) as? T {
            return object
        }
        return nil
    }
    
    public func getObject<T>(withType type: T.Type) -> T? where T: NSObject {
        if let object = findBinding(type: type) as? T {
            return object
        }
        return type.init()
    }
    
    public func getObject<T>(withType type: T.Type) -> T? where T: Creatable {
        if let object = findBinding(type: type) as? T {
            return object
        }
        if let object = type.init(injector: self) {
            return object
        }
        return nil
    }
    
    public func getObject<T>(withType type: T.Type) -> T? where T: Injectable {
        if let object = findBinding(type: type) as? T {
            return object
        }
        if let object = type.init(injector: self) {
            object.injectDependencies(injector: self)
            return object
        }
        return nil
    }
    
    public func getObject<T>(withType type: T.Type) -> T? where T: NSObject, T: Injectable {
        if let object = findBinding(type: type) as? T {
            return object
        }
        if let object = type.init(injector: self) {
            object.injectDependencies(injector: self)
            return object
        }
        return nil
    }
    
}
