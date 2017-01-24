import Quick
import Nimble
@testable import Swifjection

class SwifjectionIntegrationTests: QuickSpec {
    
    override func spec() {
        
        var injector: Swifjector!
        var bindings: Bindings!
        
        var returnedObject: AnyObject?
        
        beforeEach {
            bindings = Bindings()
            injector = Swifjector(bindings: bindings)
        }
        
        context("when object is bound to type") {
            
            var object: EmptySwiftClass!
            
            beforeEach {
                object = EmptySwiftClass()
                bindings.bind(object: object, toType: EmptySwiftClass.self)
                
                returnedObject = injector.getObject(withType: EmptySwiftClass.self)
            }
            
            it("should return bound object") {
                expect(returnedObject).to(beIdenticalTo(object))
            }
            
        }
        
        context("when closure is bound to type") {
            
            var closureCalled = false
            var object: EmptySwiftClass!
            
            beforeEach {
                object = EmptySwiftClass()
                bindings.bind(type: EmptySwiftClass.self) { injector in
                    closureCalled = true
                    return object
                }
                
                returnedObject = injector.getObject(withType: EmptySwiftClass.self)
            }
            
            it("should call the closure") {
                expect(closureCalled).to(beTrue())
            }
            it("should return object from the closure") {
                expect(returnedObject).to(beIdenticalTo(object))
            }
            
        }
        
        context("when type is bound as singleton") {
            
            var secondReturnedObject: AnyObject?
            var thirdReturnedObject: AnyObject?
            var fourthReturnedObject: AnyObject?
            
            beforeEach {
                bindings.bindSingleton(forType: InjectableClass.self)
                
                returnedObject = injector.getObject(withType: InjectableClass.self)
                secondReturnedObject = injector.getObject(withType: InjectableClass.self)
                thirdReturnedObject = injector.getObject(withType: InjectableClass.self)
                fourthReturnedObject = injector.getObject(withType: InjectableClass.self)
            }
            
            it("first returned object should be equal to second returned object") {
                expect(returnedObject).to(beIdenticalTo(secondReturnedObject))
            }
            
            it("second returned object should be equal to third returned object") {
                expect(secondReturnedObject).to(beIdenticalTo(thirdReturnedObject))
            }
            
            it("third returned object should be equal to fourth returned object") {
                expect(thirdReturnedObject).to(beIdenticalTo(fourthReturnedObject))
            }
            
        }
        
        context("when type is bound to other type") {
            
            beforeEach {
                bindings.bind(type: InjectableClass.self, toType: InjectableClassProtocol.self)
            }
            
            context("and there's no other binding for the bound type") {
                
                beforeEach {
                    returnedObject = injector.getObject(withType: InjectableClassProtocol.self)
                }
                
                it("should return object of the bound type") {
                    expect(returnedObject as? InjectableClass).notTo(beNil())
                }
                
            }
            
            context("and there's object bound to the bound type") {
                
                var object: InjectableClass!
                
                beforeEach {
                    object = InjectableClass()
                    bindings.bind(object: object, toType: InjectableClass.self)
                    returnedObject = injector.getObject(withType: InjectableClassProtocol.self)
                }
                
                it("should return bound object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }
                
            }
            
            context("and there's closure bound to the bound type") {
                
                var closureCalled = false
                var object: InjectableClass!
                
                beforeEach {
                    object = InjectableClass()
                    bindings.bind(type: InjectableClass.self) { injector in
                        closureCalled = true
                        return object
                    }
                    
                    returnedObject = injector.getObject(withType: InjectableClassProtocol.self)
                }
                
                it("should call the closure") {
                    expect(closureCalled).to(beTrue())
                }
                it("should return object from the closure") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }
                
            }
            
            context("and the bound type is bound as singleton") {
                
                var secondReturnedObject: AnyObject?
                var thirdReturnedObject: AnyObject?
                var fourthReturnedObject: AnyObject?
                
                beforeEach {
                    bindings.bindSingleton(forType: InjectableClass.self)
                    
                    returnedObject = injector.getObject(withType: InjectableClassProtocol.self)
                    secondReturnedObject = injector.getObject(withType: InjectableClassProtocol.self)
                    thirdReturnedObject = injector.getObject(withType: InjectableClassProtocol.self)
                    fourthReturnedObject = injector.getObject(withType: InjectableClassProtocol.self)
                }
                
                it("first returned object should be equal to second returned object") {
                    expect(returnedObject).to(beIdenticalTo(secondReturnedObject))
                }
                
                it("second returned object should be equal to third returned object") {
                    expect(secondReturnedObject).to(beIdenticalTo(thirdReturnedObject))
                }
                
                it("third returned object should be equal to fourth returned object") {
                    expect(thirdReturnedObject).to(beIdenticalTo(fourthReturnedObject))
                }
                
            }
            
        }
        
    }
    
}
