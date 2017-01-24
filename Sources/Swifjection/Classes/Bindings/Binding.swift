//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

public protocol Binding {
    /**
     - Returns: instance of object, or nil
     */
    func getObject(withInjector injector: Injecting) -> Any?
}
