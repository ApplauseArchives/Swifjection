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

        context("when created with InjectCreatable type") {

            beforeEach {
                let bindings = Bindings()
                bindings.bind(object: ClassConformingToProtocol(), toType: EmptySwiftProtocol.self)
                bindings.bind(object: EmptySwiftClass(), toType: EmptySwiftClass.self)
                let swifjector = Swifjector(bindings: bindings)
                object = InjectCreatableClass(injector: swifjector)
                injector.objectToReturn = object
                typeBinding = TypeBinding(withType: InjectCreatableClass.self)
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
                    expect(injector.passedType).to(beIdenticalTo(InjectCreatableClass.self))
                }
                it("should return the object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }

            }

        }
        
        context("when created with NSObject<InjectCreatable> type") {
            
            beforeEach {
                let bindings = Bindings()
                bindings.bind(object: ClassConformingToProtocol(), toType: EmptySwiftProtocol.self)
                bindings.bind(object: EmptySwiftClass(), toType: EmptySwiftClass.self)
                let swifjector = Swifjector(bindings: bindings)
                object = InjectCreatableObjCClass(injector: swifjector)
                injector.objectToReturn = object
                typeBinding = TypeBinding(withType: InjectCreatableObjCClass.self)
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
                    expect(injector.passedType).to(beIdenticalTo(InjectCreatableObjCClass.self))
                }
                it("should return the object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }
                
            }
            
        }
        
    }
    
}
