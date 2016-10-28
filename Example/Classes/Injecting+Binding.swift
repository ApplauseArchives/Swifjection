//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

public extension Injecting {
    
    func findBinding(type: Any) -> AnyObject? {
        let typeName = "\(type)"
        if let binding = bindings[typeName] {
            return binding
        }
        if let closureBinding = closureBindings[typeName] {
            return closureBinding(self)
        }
        return nil
    }
    
    mutating func bind(object: AnyObject, toType type: Any) {
        let typeName = "\(type)"
        bindings[typeName] = object
    }
    
    mutating func bind(closure: @escaping ((Injecting) -> AnyObject), toType type: Any) {
        let typeName = "\(type)"
        closureBindings[typeName] = closure
    }
}
