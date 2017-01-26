//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import Foundation
import Swifjection

protocol Fie {}

class Fee: Fie, Injectable {
    convenience required init?(injector: Injecting) {
        self.init()
    }
}
