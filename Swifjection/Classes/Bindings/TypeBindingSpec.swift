import Quick
import Nimble
@testable import Swifjection

class TypeBindingSpec: QuickSpec {
    
    override func spec() {
        
        var typeBinding: TypeBinding!
        var object: AnyObject!
        var injector: FakeInjector!
        
        beforeEach {
            injector = FakeInjector()
        }
        
        context("when created with non NSObject and non Injectable type") {
            
            beforeEach {
                object = EmptySwiftClass()
                injector.objectToReturn = object
                typeBinding = TypeBinding(withType: EmptySwiftClass.self)
            }
            
            describe("getObject") {
                
                var returnedObject: Any?
                
                beforeEach {
                    returnedObject = typeBinding.getObject(withInjector: injector)
                }
                
                it("should create object using injector") {
                    expect(injector.getObjectCalled).to(beTrue())
                }
                it("should pass proper type to injector") {
                    expect(injector.passedType).to(beIdenticalTo(EmptySwiftClass.self))
                }
                it("should return the object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }
                
            }
            
        }
        
        context("when created with Injectable type") {
            
            beforeEach {
                object = InjectableClass()
                injector.objectToReturn = object
                typeBinding = TypeBinding(withType: InjectableClass.self)
            }
            
            describe("getObject") {
                
                var returnedObject: Any?
                
                beforeEach {
                    returnedObject = typeBinding.getObject(withInjector: injector)
                }
                
                it("should create object using injector") {
                    expect(injector.getObjectCalled).to(beTrue())
                }
                it("should pass proper type to injector") {
                    expect(injector.passedType).to(beIdenticalTo(InjectableClass.self))
                }
                it("should return the object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }
                
            }
            
        }
        
        context("when created with NSObject type") {
            
            beforeEach {
                object = ObjCClass()
                injector.objectToReturn = object
                typeBinding = TypeBinding(withType: ObjCClass.self)
            }
            
            describe("getObject") {
                
                var returnedObject: Any?
                
                beforeEach {
                    returnedObject = typeBinding.getObject(withInjector: injector)
                }
                
                it("should create object using injector") {
                    expect(injector.getObjectCalled).to(beTrue())
                }
                it("should pass proper type to injector") {
                    expect(injector.passedType).to(beIdenticalTo(ObjCClass.self))
                }
                it("should return the object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }
                
            }
            
        }
        
        context("when created with NSObject<Injectable> type") {
            
            beforeEach {
                object = InjectableObjCClass()
                injector.objectToReturn = object
                typeBinding = TypeBinding(withType: InjectableObjCClass.self)
            }
            
            describe("getObject") {
                
                var returnedObject: Any?
                
                beforeEach {
                    returnedObject = typeBinding.getObject(withInjector: injector)
                }
                
                it("should create object using injector") {
                    expect(injector.getObjectCalled).to(beTrue())
                }
                it("should pass proper type to injector") {
                    expect(injector.passedType).to(beIdenticalTo(InjectableObjCClass.self))
                }
                it("should return the object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }
                
            }
            
        }
        
    }
    
}
