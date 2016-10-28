//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

class SwifjectorFactory {
    
    var injector: Injecting?
    
    private var runningSpecs: Bool {
        get { return NSClassFromString("XCTest") != nil }
    }
    
    init(injector: Injecting) {
        self.injector = injector
    }

    func createInjector() -> Injecting? {
        guard runningSpecs == false else {
            return nil
        }
        return injector
    }
    
}
