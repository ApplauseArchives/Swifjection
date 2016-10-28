//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation

public protocol Injecting {
    var bindings: [String: AnyObject] { get set }
    var closureBindings: [String: ((Injecting) -> AnyObject)] {get set}
    
    func getObject<T>(withType type: T.Type) -> T?
    func getObject<T>(withType type: T.Type) -> T? where T: NSObject
    func getObject<T>(withType type: T.Type) -> T? where T: Injectable
    func getObject<T>(withType type: T.Type) -> T? where T: NSObject, T: Injectable
    
    mutating func bind(object: AnyObject, toType: Any)
    mutating func bind(closure: @escaping ((Injecting) -> AnyObject), toType type: Any)
}
