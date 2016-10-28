//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

open class Bindings {
    weak var injector: Injecting?
    var bindings: [String: AnyObject] = [:]
    var closureBindings: [String: ((Injecting) -> AnyObject)] = [:]

    public init() { }
    
    public func findBinding(type: Any) -> AnyObject? {
        let typeName = "\(type)"
        if let binding = bindings[typeName] {
            return binding
        }
        if let injector = self.injector, let closureBinding = closureBindings[typeName] {
            return closureBinding(injector)
        }
        return nil
    }

    public func bind(object: AnyObject, toType type: Any) {
        let typeName = "\(type)"
        bindings[typeName] = object
    }

    public func bind(closure: @escaping ((Injecting) -> AnyObject), toType type: Any) {
        let typeName = "\(type)"
        closureBindings[typeName] = closure
    }

}
