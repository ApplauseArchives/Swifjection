//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import Foundation

class Bar: Injectable {
    var foo: Foo
    var singleton: ExampleSingleton?
    var object: MyObject?
    
    init(foo: Foo) {
        self.foo = foo
    }
    
    convenience required init?(injector: Injecting) {
        guard let foo = injector.getObject(withType: Foo.self) else {
            return nil
        }
        self.init(foo: foo)
        singleton = injector.getObject(withType: ExampleSingleton.self)
        object = injector.getObject(withType: MyObject.self)
    }
}
