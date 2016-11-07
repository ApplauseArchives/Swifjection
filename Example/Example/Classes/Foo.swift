//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

class Foo: Injectable {
    convenience required init?(injector: Swifjector) {
        self.init()
    }    
}
