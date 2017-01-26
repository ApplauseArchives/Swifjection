//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import Foundation
import Swifjection

class Bar: Injectable {
    var foo: Foo
    var fie: Fie?
    var fie2: Fie?
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
        fie = injector.getObject(withType: Fie.self)
        fie2 = injector.getObject(withType: Fie.self)
        singleton = injector.getObject(withType: ExampleSingleton.self)
        object = injector.getObject(withType: MyObject.self)
    }
}
