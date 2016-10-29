@testable import Swifjection

class FakeBindings: Bindings {}

class FakeInjector: Injecting {
    
    var bindings: Bindings
    
    convenience init() {
        self.init(bindings: FakeBindings())
    }
    
    public required init(bindings: Bindings) {
        self.bindings = bindings
    }
    
}
