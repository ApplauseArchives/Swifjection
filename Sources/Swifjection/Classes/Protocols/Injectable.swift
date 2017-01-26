//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import Foundation

/// Describes a type which is compatible with Swijection -- it can have its dependencies injected and can be created from injector  

public protocol Injectable {
    /**
     Initializes injectable object, using provided `injector`.
     
     The `injector` object can be used to inject inner dependencies of created `Injectable` object.
     
     - Parameter injector: An object used to inject inner dependencies.
     
     - Returns: An initialized `Injectable` object, or nil.
     */
    init?(injector: Injecting)
    
    /**
     Injects inner dependencies using provided `injector` object.
     
     When implementing an object conforming to `Injectable` protocol, this function is the place where injector should be used to inject inner dependencies of the object.
     
     The `injector` object can be used to inject inner dependencies of created `Injectable` object.
     
     - Parameter injector: An object used to inject inner dependencies.
     */
    func injectDependencies(injector: Injecting)
}

public extension Injectable {
    func injectDependencies(injector: Injecting) {}
}
