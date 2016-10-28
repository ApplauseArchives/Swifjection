//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

class Swifjector: Injecting {
    var bindings: Bindings
    
    required init(bindings: Bindings) {
        self.bindings = bindings
        self.bindings.injector = self
    }
}
