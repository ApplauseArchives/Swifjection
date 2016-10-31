import Quick
import Nimble
@testable import Swifjection

class ObjectBindingSpec: QuickSpec {
    
    override func spec() {
        
        var closureBinding: ObjectBinding?
        var object: AnyObject!
        
        beforeEach {
            object = EmptySwiftClass()
            closureBinding = ObjectBinding(withObject: object)
        }
        
        describe("getObject") {
            
            var returnedObject: Any?
            
            beforeEach {
                returnedObject = closureBinding?.getObject(withInjector: FakeInjector())
            }
            
            it("should return the object") {
                expect(returnedObject).to(beIdenticalTo(object))
            }
            
        }
        
    }
    
}
