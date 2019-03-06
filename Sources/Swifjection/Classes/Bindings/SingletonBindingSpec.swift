import Quick
import Nimble
@testable import Swifjection

class SingletonBindingSpec: QuickSpec {
    
    override func spec() {
        
        var closureBinding: SingletonBinding?
        
        context("created with Creatable type") {
            
            beforeEach {
                closureBinding = SingletonBinding(withType: CreatableClass.self)
            }
            
            describe("getObject") {
                
                var returnedObject: Any?
                
                beforeEach {
                    returnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                }
                
                it("should create and return object conforming to Injctable protocol") {
                    expect(returnedObject as? Creatable).notTo(beNil())
                }
                it("should create and return object of CreatableClass type") {
                    expect(returnedObject as? CreatableClass).notTo(beNil())
                }
                
                context("when called second time") {
                    
                    var anotherReturnedObject: Any?
                    
                    beforeEach {
                        anotherReturnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                    }
                    
                    it("should return object equal to previous one") {
                        expect(anotherReturnedObject).to(beIdenticalTo(returnedObject))
                    }
                    it("should initialize the object only once") {
                        let object = anotherReturnedObject as? CreatableClass
                        expect(object?.initCallsCount).to(equal(1))
                    }
                    it("should inject dependencies into the object only once") {
                        let object = anotherReturnedObject as? CreatableClass
                        expect(object?.injectDependenciesCallsCount).to(equal(1))
                    }
                    
                }
                
            }
            
        }
        
        context("created with NSObject type") {
            
            beforeEach {
                closureBinding = SingletonBinding(withType: ObjCClass.self)
            }
            
            describe("getObject") {
                
                var returnedObject: Any?
                
                beforeEach {
                    returnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                }
                
                it("should create and return object of NSObject type") {
                    expect(returnedObject as? NSObject).notTo(beNil())
                }
                it("should create and return object of ObjCClass type") {
                    expect(returnedObject as? ObjCClass).notTo(beNil())
                }
                
                context("when called second time") {
                    
                    var anotherReturnedObject: Any?
                    
                    beforeEach {
                        anotherReturnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                    }
                    
                    it("should return object equal to previous one") {
                        expect(anotherReturnedObject).to(beIdenticalTo(returnedObject))
                    }
                    it("should initialize the object only once") {
                        let object = anotherReturnedObject as? ObjCClass
                        expect(object?.initCallsCount).to(equal(1))
                    }
                    
                }
                
            }
            
        }
        
        context("created with NSObject<Creatable> type") {
            
            beforeEach {
                closureBinding = SingletonBinding(withType: CreatableObjCClass.self)
            }
            
            describe("getObject") {
                
                var returnedObject: Any?
                
                beforeEach {
                    returnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                }
                
                it("should create and return object conforming to Injctable protocol") {
                    expect(returnedObject as? Creatable).notTo(beNil())
                }
                it("should create and return object of NSObject type") {
                    expect(returnedObject as? NSObject).notTo(beNil())
                }
                it("should create and return object of CreatableObjCClass type") {
                    expect(returnedObject as? CreatableObjCClass).notTo(beNil())
                }
                
                context("when called second time") {
                    
                    var anotherReturnedObject: Any?
                    
                    beforeEach {
                        anotherReturnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                    }
                    
                    it("should return object equal to previous one") {
                        expect(anotherReturnedObject).to(beIdenticalTo(returnedObject))
                    }
                    it("should initialize the object only once") {
                        let object = anotherReturnedObject as? CreatableObjCClass
                        expect(object?.initCallsCount).to(equal(1))
                    }
                    it("should inject dependencies into the object only once") {
                        let object = anotherReturnedObject as? CreatableObjCClass
                        expect(object?.injectDependenciesCallsCount).to(equal(1))
                    }
                    
                }
                
            }
        }
        
        context("created with not Creatable, nor NSObject type") {
            
            beforeEach {
                closureBinding = SingletonBinding(withType: EmptySwiftClass.self)
            }
            
            describe("getObject") {
                
                var returnedObject: Any?
                
                beforeEach {
                    returnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                }
                
                it("should return nil") {
                    expect(returnedObject).to(beNil())
                }
            }
        }
    }
    
}
