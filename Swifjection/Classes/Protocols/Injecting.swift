//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

protocol Injecting: class {
    var bindings: Bindings {get}
    init(bindings: Bindings)
    
    func getObject<T>(withType type: T.Type) -> T?
    func getObject<T>(withType type: T.Type) -> T? where T: NSObject
    func getObject<T>(withType type: T.Type) -> T? where T: Injectable
    func getObject<T>(withType type: T.Type) -> T? where T: NSObject, T: Injectable
}
