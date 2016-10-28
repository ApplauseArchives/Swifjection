//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Injectable {
    
    var bar: Bar?
    
    required convenience init?(injector: Injecting) {
        self.init()
    }
    
    func injectDependencies(injector: Injecting) {
        bar = injector.getObject(withType: Bar.self)
    }
}

