//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

public class Swifjector: Injecting {
    public var bindings: Bindings
    
    required public init(bindings: Bindings) {
        self.bindings = bindings
        self.bindings.injector = self
    }
}
