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
            
            context("using getObject function", { 
                
                beforeEach {
                    object = EmptySwiftClass()
                    bindings.bind(object: object, toType: EmptySwiftClass.self)
                    
                    returnedObject = injector.getObject(withType: EmptySwiftClass.self)
                }
                
                it("should return bound object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }

            });
            
            context("using subscript", {
                
                beforeEach {
                    object = EmptySwiftClass()
                    bindings.bind(object: object, toType: EmptySwiftClass.self)
                    
                    returnedObject = injector[EmptySwiftClass.self] as AnyObject
                }
                
                it("should return bound object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }
                
            });
            
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
                bindings.bindSingleton(forType: CreatableClass.self)
                
                returnedObject = injector.getObject(withType: CreatableClass.self)
                secondReturnedObject = injector.getObject(withType: CreatableClass.self)
                thirdReturnedObject = injector.getObject(withType: CreatableClass.self)
                fourthReturnedObject = injector.getObject(withType: CreatableClass.self)
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
                bindings.bind(type: CreatableClass.self, toType: CreatableClassProtocol.self)
            }
            
            context("and there's no other binding for the bound type") {
                
                beforeEach {
                    returnedObject = injector.getObject(withType: CreatableClassProtocol.self)
                }
                
                it("should return object of the bound type") {
                    expect(returnedObject as? CreatableClass).notTo(beNil())
                }
                
            }
            
            context("and there's object bound to the bound type") {
                
                var object: CreatableClass!
                
                beforeEach {
                    object = CreatableClass()
                    bindings.bind(object: object, toType: CreatableClass.self)
                    returnedObject = injector.getObject(withType: CreatableClassProtocol.self)
                }
                
                it("should return bound object") {
                    expect(returnedObject).to(beIdenticalTo(object))
                }
                
            }
            
            context("and there's closure bound to the bound type") {
                
                var closureCalled = false
                var object: CreatableClass!
                
                beforeEach {
                    object = CreatableClass()
                    bindings.bind(type: CreatableClass.self) { injector in
                        closureCalled = true
                        return object
                    }
                    
                    returnedObject = injector.getObject(withType: CreatableClassProtocol.self)
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
                    bindings.bindSingleton(forType: CreatableClass.self)
                    
                    returnedObject = injector.getObject(withType: CreatableClassProtocol.self)
                    secondReturnedObject = injector.getObject(withType: CreatableClassProtocol.self)
                    thirdReturnedObject = injector.getObject(withType: CreatableClassProtocol.self)
                    fourthReturnedObject = injector.getObject(withType: CreatableClassProtocol.self)
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
