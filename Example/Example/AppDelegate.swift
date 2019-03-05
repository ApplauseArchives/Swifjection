//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import UIKit
import Swifjection

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var injector: Injecting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        injector = SwifjectorFactory(bindings: MyBindings()).injector
        
        if let injector = self.injector, let rootViewController = window?.rootViewController as? ViewController {
            rootViewController.injectDependencies(injector: injector)
        }
        return true
    }
}

