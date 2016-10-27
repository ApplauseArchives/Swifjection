//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

protocol Injecting {
    var bindings: [String: AnyObject] { get set }
    var closureBindings: [String: ((Injecting) -> AnyObject)] {get set}
    
    func createDependency<T>(withType type: T.Type) -> T?
    func createDependency<T>(withType type: T.Type) -> T? where T: NSObject
    func createDependency<T>(withType type: T.Type) -> T? where T: Creatable
    func createDependency<T>(withType type: T.Type) -> T? where T: Injectable
    func createDependency<T>(withType type: T.Type) -> T? where T: NSObject, T: Injectable
    
    mutating func bind(object: AnyObject, toType: Any)
    mutating func bind(closure: @escaping ((Injecting) -> AnyObject), toType type: Any)
}
