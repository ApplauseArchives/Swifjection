//
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import UIKit
import Swifjection

class ViewController: UIViewController, Creatable, Injectable {
    
    var bar: Bar?
    var singleton: ExampleSingleton?
    var automaticallyInjectableObject: AutoInjectableObject?
    var injectCreatableObject: InjectCreatableObject?
    
    func injectDependencies(injector: Injecting) {
        bar = injector.getObject(withType: Bar.self)
        singleton = injector.getObject(withType: ExampleSingleton.self)
        automaticallyInjectableObject = injector.getObject(withType: AutoInjectableObject.self)
        injectCreatableObject = injector.getObject(withType: InjectCreatableObject.self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        NSLog("\(String(describing: bar))")
        NSLog("\(String(describing: singleton))")
        NSLog("\(String(describing: automaticallyInjectableObject))")
        NSLog("\(String(describing: injectCreatableObject))")
    }
}

