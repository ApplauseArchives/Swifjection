//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

open class Bindings {
    weak var injector: Injecting?
    var bindings: [String: Binding] = [:]

    public init() { }
    
    public func findBinding(type: Any) -> AnyObject? {
        let typeName = "\(type)"
        if let injector = self.injector, let binding = bindings[typeName] {
            return binding.getObject(withInjector: injector)
        }
        return nil
    }

    public func bind(object: AnyObject, toType type: Any) {
        let typeName = "\(type)"
        bindings[typeName] = ObjectBinding(withObject: object)
    }

    public func bind(closure: @escaping ((Injecting) -> AnyObject), toType type: Any) {
        let typeName = "\(type)"
        bindings[typeName] = ClosureBinding(withClosure: closure)
    }
    
    public func bindSingleton<T>(forType type: T.Type) where T: Injectable {
        let typeName = "\(type)"
        bindings[typeName] = SingletonBinding(withType: type)
    }
    
    public func bindSingleton<T>(forType type: T.Type) where T: NSObject {
        let typeName = "\(type)"
        bindings[typeName] = SingletonBinding(withType: type)
    }
    
    public func bindSingleton<T>(forType type: T.Type) where T: NSObject, T: Injectable {
        let typeName = "\(type)"
        bindings[typeName] = SingletonBinding(withType: type)
    }

}
