//
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import Foundation
import Swifjection

class MyBindings: Bindings {
    
    override init() {
        super.init()        
        bind(object: Foo(), toType: Foo.self)
        bindSingleton(forType: ExampleSingleton.self)
        bindSingleton(forType: Fee.self)
        bind(type: Fee.self, toType:Fie.self)
    }
}
