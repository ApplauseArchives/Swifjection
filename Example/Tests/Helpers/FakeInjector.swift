@testable import Swifjection

class FakeBindings: Bindings {}

class FakeInjector: Swifjector {
    
    convenience init() {
        self.init(bindings: FakeBindings())
    }
    
}
