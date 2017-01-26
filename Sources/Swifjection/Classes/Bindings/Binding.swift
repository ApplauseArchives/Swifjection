//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

/// Describes single binding in `Bindings` 

public protocol Binding {
    /**
     - Returns: instance of object, or `nil`
     */
    func getObject(withInjector injector: Injecting) -> Any?
}
