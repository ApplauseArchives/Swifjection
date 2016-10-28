//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

public protocol Injectable {
    init?(injector: Injecting)
    func injectDependencies(injector: Injecting)
}

public extension Injectable {
    func injectDependencies(injector: Injecting) {}
}
