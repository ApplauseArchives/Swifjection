//
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import Foundation
import Swifjection

class Bar: Creatable, Injectable {
    var foo: Foo
    var fie: Fie?
    var fie2: Fie?
    var singleton: ExampleSingleton?
    var object: MyObject?
    
    init(foo: Foo) {
        self.foo = foo
    }
    
    required convenience init() {
        self.init(foo: Foo())
    }

    func injectDependencies(injector: Injecting) {
        if let foo = injector.getObject(withType: Foo.self) {
            self.foo = foo
        }
        fie = injector.getObject(withType: Fie.self)
        fie2 = injector.getObject(withType: Fie.self)
        singleton = injector.getObject(withType: ExampleSingleton.self)
        object = injector.getObject(withType: MyObject.self)
    }
}
