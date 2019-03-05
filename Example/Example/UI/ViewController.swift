//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import UIKit
import Swifjection

class ViewController: UIViewController, Injectable {
    
    var bar: Bar?
    var singleton: ExampleSingleton?
    var automaticallyInjectableObject: AutoInjectableObject?
    
    required convenience init?(injector: Injecting) {
        self.init()
    }
    
    func injectDependencies(injector: Injecting) {
        bar = injector.getObject(withType: Bar.self)
        singleton = injector.getObject(withType: ExampleSingleton.self)
        automaticallyInjectableObject = injector.getObject(withType: AutoInjectableObject.self)
    }
}

