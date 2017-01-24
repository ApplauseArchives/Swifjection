//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

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
