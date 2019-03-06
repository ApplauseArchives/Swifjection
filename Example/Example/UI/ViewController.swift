//
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import UIKit
import Swifjection

class ViewController: UIViewController, Creatable, Injectable {
    
    var bar: Bar?
    var singleton: ExampleSingleton?
    var automaticallyInjectableObject: AutoInjectableObject?
    
    func injectDependencies(injector: Injecting) {
        bar = injector.getObject(withType: Bar.self)
        singleton = injector.getObject(withType: ExampleSingleton.self)
        automaticallyInjectableObject = injector.getObject(withType: AutoInjectableObject.self)
    }
}

