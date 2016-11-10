@testable import Swifjection
import Foundation

class FakeBindings: Bindings {}

class FakeInjector: Injecting {
    
    var bindings: Bindings
    
    var objectToReturn: Any?
    var getObjectCalled = false
    var passedType: Any.Type?
    
    convenience init() {
        self.init(bindings: FakeBindings())
    }
    
    public required init(bindings: Bindings) {
        self.bindings = bindings
    }
    
    public func getObject<T>(withType type: T.Type) -> T? {
        self.getObjectCalled = true
        self.passedType = type
        return self.objectToReturn as! T?
    }
    
    public func getObject<T>(withType type: T.Type) -> T? where T: Injectable {
        self.getObjectCalled = true
        self.passedType = type
        return self.objectToReturn as! T?
    }
    
    public func getObject<T>(withType type: T.Type) -> T? where T: NSObject {
        self.getObjectCalled = true
        self.passedType = type
        return self.objectToReturn as! T?
    }
    
    public func getObject<T>(withType type: T.Type) -> T? where T: NSObject, T: Injectable {
        self.getObjectCalled = true
        self.passedType = type
        return self.objectToReturn as! T?
    }
    
}
