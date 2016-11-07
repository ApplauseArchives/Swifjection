//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

class Bar: Injectable {
    var foo: Foo
    
    init(foo: Foo) {
        self.foo = foo
    }
    
    convenience required init?(injector: Swifjector) {
        guard let foo = injector.getObject(withType: Foo.self) else {
            return nil
        }
        self.init(foo: foo)
    }
}
