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
        
        context("when created with non NSObject and non Creatable type") {
            
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
        
        context("when created with Creatable type") {
            
            beforeEach {
                object = CreatableClass()
                injector.objectToReturn = object
                typeBinding = TypeBinding(withType: CreatableClass.self)
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
                    expect(injector.passedType).to(beIdenticalTo(CreatableClass.self))
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
        
        context("when created with NSObject<Creatable> type") {
            
            beforeEach {
                object = CreatableObjCClass()
                injector.objectToReturn = object
                typeBinding = TypeBinding(withType: CreatableObjCClass.self)
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
                    expect(injector.passedType).to(beIdenticalTo(CreatableObjCClass.self))
                }
                it("should return the object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }
                
            }
            
        }
        
    }
    
}
