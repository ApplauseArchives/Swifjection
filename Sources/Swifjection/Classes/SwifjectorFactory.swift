//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

public class SwifjectorFactory {
    
    public private(set) var injector: Injecting?
    
    private var runningSpecs: Bool {
        get { return NSClassFromString("XCTest") != nil }
    }
    
    public init(bindings: Bindings) {
        if runningSpecs == false {
            self.injector = Swifjector(bindings: bindings)
        }
    }
}
