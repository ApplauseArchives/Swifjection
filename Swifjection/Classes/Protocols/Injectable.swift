//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

public protocol Injectable {
    init?(injector: Swifjector)
    func injectDependencies(injector: Swifjector)
}

public extension Injectable {
    func injectDependencies(injector: Swifjector) {}
}
