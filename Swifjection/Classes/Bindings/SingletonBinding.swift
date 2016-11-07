//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

public class SingletonBinding: Binding {
    
    var type: Any.Type
    var instance: Any?
    
    public init(withType type: Any.Type) {
        self.type = type
    }
    
    public func getObject(withInjector injector: Swifjector) -> Any {
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
