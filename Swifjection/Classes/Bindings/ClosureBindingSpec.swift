import Quick
import Nimble
@testable import Swifjection

class ClosureBindingSpec: QuickSpec {
    
    override func spec() {
        
        var closureBinding: ClosureBinding?
        var object: AnyObject!
        
        beforeEach {
            object = EmptySwiftClass()
            closureBinding = ClosureBinding(withClosure: { injector in
                return object
            })
        }
        
        describe("getObject") {
            
            var returnedObject: AnyObject?
            
            beforeEach {
                returnedObject = closureBinding?.getObject(withInjector: FakeInjector())
            }
            
            it("should return the object") {
                expect(returnedObject).to(beIdenticalTo(object))
            }
            
        }
        
    }
    
}
