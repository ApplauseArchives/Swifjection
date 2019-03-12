//
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import Foundation
import Swifjection

class InjectCreatableObject: InjectCreatable {

    var injector: Injecting

    var foo: Foo?
    var fie: Fie?
    var fie2: Fie?
    var singleton: ExampleSingleton?
    var object: MyObject?

    required init?(injector: Injecting) {
        guard let foo = injector.getObject(withType: Foo.self),
              let fie = injector.getObject(withType: Fie.self),
              let fie2 = injector.getObject(withType: Fie.self),
              let singleton = injector.getObject(withType: ExampleSingleton.self),
              let object = injector.getObject(withType: MyObject.self) else {
            assertionFailure("Could not initialize all stored properties")
            return nil
        }
        self.injector = injector
        self.foo = foo
        self.fie = fie
        self.fie2 = fie2
        self.singleton = singleton
        self.object = object
    }

}
