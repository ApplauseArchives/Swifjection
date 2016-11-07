//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Injectable {
    
    var bar: Bar?
    
    required convenience init?(injector: Swifjector) {
        self.init()
    }
    
    func injectDependencies(injector: Swifjector) {
        bar = injector.getObject(withType: Bar.self)
    }
}

