//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

protocol Creatable {
    init?(injector: Injecting)
}

protocol Injectable: Creatable {
    var injector: Injecting? {get set}
    func injectDependencies(injector: Injecting)
}

extension Injectable {
    func injectDependencies(injector: Injecting) {}
}
