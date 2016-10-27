//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

@testable import Swifjection

class SpecInjector: Injecting {
    
    var bindings: [String : AnyObject] = [:]
    var closureBindings: [String : ((Injecting) -> AnyObject)] = [:]
    
}
