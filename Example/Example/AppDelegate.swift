//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var injector: Injecting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        injector = SwifjectorFactory(bindings: MyBindings()).injector
        
        if let injector = self.injector, let rootViewController = window?.rootViewController as? ViewController {
            rootViewController.injectDependencies(injector: injector)
        }
        return true
    }
}

