//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import Foundation

public class SingletonBinding: Binding {
    /**
     Returns the `type` provided during initialization of binding.
     */
    var type: Any.Type
    
    /**
     An instance of provided `type`, created during first call of the `getObject(withInjector injector: Injecting) -> Any?` function.
     */
    var instance: Any?
    
    /**
     Initializes `SingletonBinding` object, using provided `type`.
     
     - Parameter type: An Type which should be bound in singleton scope.
     
     - Returns: An initialized `SingletonBinding` object.
     */
    public init(withType type: Any.Type) {
        self.type = type
    }
    
    /**
     Creates and keeps an instance of provided `type`.
     
     During first call, a new instance of `type` is created using the `injector`, and assigned to the `instance` property.
     Each subsequent call uses the object assigned to `instance` property.
     
     - Parameter injector: An `injector` used to create new instance, during first call to the function.
     
     - Returns: An singleton instance of `type` provided during initialization of this binding.
     */
    public func getObject(withInjector injector: Injecting) -> Any? {
        if self.instance == nil {
            if let type = self.type as? Injectable.Type {
                let instance = type.init(injector: injector)
                instance?.injectDependencies(injector: injector)
                self.instance = instance
            } else if let type = self.type as? NSObject.Type {
                self.instance = type.init()
            }
        }
        return self.instance!
    }
}
