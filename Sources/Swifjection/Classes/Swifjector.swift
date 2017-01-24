//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

public class Swifjector: Injecting {
    /**
     Returns the `bindings` object provided to initializer.
     */
    public var bindings: Bindings
    
    /**
     Initializes `Swifjector` object, using provided `bindings`, which contains information about instances, closures bound to types, or types bound in singleton scope.
     
     - Parameter bindings: Object containing information about instances, closures bound to types, or types bound in singleton scope
     
     - Returns: An initialized `Swifjector` object.
     */
    required public init(bindings: Bindings) {
        self.bindings = bindings
        self.bindings.injector = self
    }
}
