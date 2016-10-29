import Quick
import Nimble
@testable import Swifjection

class SingletonBindingSpec: QuickSpec {
    
    override func spec() {
        
        var closureBinding: SingletonBinding?
        
        context("created with Injectable type") {
            
            beforeEach {
                closureBinding = SingletonBinding(withType: InjectableClass.self)
            }
            
            describe("getObject") {
                
                var returnedObject: AnyObject?
                
                beforeEach {
                    returnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                }
                
                it("should create and return object conforming to Injctable protocol") {
                    expect(returnedObject as? Injectable).notTo(beNil())
                }
                it("should create and return object of InjectableClass type") {
                    expect(returnedObject as? InjectableClass).notTo(beNil())
                }
                
                context("when called second time") {
                    
                    var anotherReturnedObject: AnyObject?
                    
                    beforeEach {
                        anotherReturnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                    }
                    
                    it("should return object equal to previous one") {
                        expect(anotherReturnedObject).to(beIdenticalTo(returnedObject))
                    }
                    it("should initialize the object only once") {
                        let object = anotherReturnedObject as? InjectableClass
                        expect(object?.initCallsCount).to(equal(1))
                    }
                    it("should inject dependencies into the object only once") {
                        let object = anotherReturnedObject as? InjectableClass
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
                
                var returnedObject: AnyObject?
                
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
                    
                    var anotherReturnedObject: AnyObject?
                    
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
        
        context("created with NSObject<Injectable> type") {
            
            beforeEach {
                closureBinding = SingletonBinding(withType: InjectableObjCClass.self)
            }
            
            describe("getObject") {
                
                var returnedObject: AnyObject?
                
                beforeEach {
                    returnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                }
                
                it("should create and return object conforming to Injctable protocol") {
                    expect(returnedObject as? Injectable).notTo(beNil())
                }
                it("should create and return object of NSObject type") {
                    expect(returnedObject as? NSObject).notTo(beNil())
                }
                it("should create and return object of InjectableObjCClass type") {
                    expect(returnedObject as? InjectableObjCClass).notTo(beNil())
                }
                
                context("when called second time") {
                    
                    var anotherReturnedObject: AnyObject?
                    
                    beforeEach {
                        anotherReturnedObject = closureBinding?.getObject(withInjector: FakeInjector())
                    }
                    
                    it("should return object equal to previous one") {
                        expect(anotherReturnedObject).to(beIdenticalTo(returnedObject))
                    }
                    it("should initialize the object only once") {
                        let object = anotherReturnedObject as? InjectableObjCClass
                        expect(object?.initCallsCount).to(equal(1))
                    }
                    it("should inject dependencies into the object only once") {
                        let object = anotherReturnedObject as? InjectableObjCClass
                        expect(object?.injectDependenciesCallsCount).to(equal(1))
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
