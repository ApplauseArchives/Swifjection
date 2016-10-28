//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

protocol Injectable {
    init?(injector: Injecting)
    func injectDependencies(injector: Injecting)
}

extension Injectable {
    func injectDependencies(injector: Injecting) {}
}
