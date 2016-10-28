//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

class Bindings {
    
    weak var injector: Injecting?
    
    var bindings: [String: AnyObject] = [:]
    var closureBindings: [String: ((Injecting) -> AnyObject)] = [:]
    
    func findBinding(type: Any) -> AnyObject? {
        let typeName = "\(type)"
        if let binding = bindings[typeName] {
            return binding
        }
        if let injector = self.injector, let closureBinding = closureBindings[typeName] {
            return closureBinding(injector)
        }
        return nil
    }
    
    func bind(object: AnyObject, toType type: Any) {
        let typeName = "\(type)"
        bindings[typeName] = object
    }
    
    func bind(closure: @escaping ((Injecting) -> AnyObject), toType type: Any) {
        let typeName = "\(type)"
        closureBindings[typeName] = closure
    }

}
