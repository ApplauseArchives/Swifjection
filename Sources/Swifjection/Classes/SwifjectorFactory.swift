//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import Foundation

/// Helper factory for creating injector, its main purpose is to NOT create default injector when application is being tested.

public class SwifjectorFactory {
    /**
     Returns `Swifjector` instance, when called while not running tests. In tests, it will be set to nil.
     */
    public private(set) var injector: Injecting?
    
    private var runningSpecs: Bool {
        get { return NSClassFromString("XCTest") != nil }
    }
    
    /**
     Initializes `SwifjectorFactory` object, using provided `bindings`, which contains information about instances, closures bound to types, or types bound in singleton scope.
     
     The `SwifjectorFactory` creates `Swifjector` instance only when not running specs. In specs, the `injector` property will contain nil.
     
     - Parameter bindings: Object containing information about instances, closures bound to types, or types bound in singleton scope. This `bindings` object will be passed to `Swifjector` initializer.
     
     - Returns: An initialized `SwifjectorFactory` object.
     */
    public init(bindings: Bindings) {
        if runningSpecs == false {
            self.injector = Swifjector(bindings: bindings)
        }
    }
}
