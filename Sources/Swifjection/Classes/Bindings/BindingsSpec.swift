import Quick
import Nimble
@testable import Swifjection

class BindingsSpec: QuickSpec {
    
    override func spec() {
        
        var bindings: Bindings!
        
        beforeEach {
            bindings = Bindings()
        }
        
        describe("bind(object:, toType:)") {
            
            context("when binding nil to some class") {
                beforeEach {
                    bindings.bind(object: nil, toType: ClassConformingToProtocol.self)
                }
                it("should NOT add binding") {
                    expect(bindings.bindings.count).to(equal(0))
                }
            }
            
            context("when binding object to it's class") {
                
                var object: AnyObject!
                
                beforeEach {
                    object = ClassConformingToProtocol()
                    bindings.bind(object: object, toType: ClassConformingToProtocol.self)
                }
                
                it("should add one binding") {
                    expect(bindings.bindings.count).to(equal(1))
                }
                
                context("when adding same object to another type") {
                    
                    beforeEach {
                        bindings.bind(object: object, toType: EmptySwiftProtocol.self)
                    }
                    
                    it("should add another binding") {
                        expect(bindings.bindings.count).to(equal(2))
                    }
                    
                }
                
                context("when adding another object binding for the same type") {
                    
                    var otherObject: AnyObject!
                    
                    beforeEach {
                        otherObject = ClassConformingToProtocol()
                        bindings.bind(object: otherObject, toType: ClassConformingToProtocol.self)
                    }
                    
                    it("should replace the binding") {
                        expect(bindings.bindings.count).to(equal(1))
                    }
                    
                    context("the binding") {
                        
                        var binding: ObjectBinding?
                        
                        beforeEach {
                            binding = bindings.bindings["\(ClassConformingToProtocol.self)"] as! ObjectBinding?
                        }
                        
                        it("should contain the other object") {
                            expect(binding?.object).to(beIdenticalTo(otherObject))
                        }
                        
                    }
                    
                }
                
            }
            
            context("when binding a struct instance to the protocol") {
                
                var structInstance: Any!
                
                beforeEach {
                    structInstance = StructConformingToProtocol()
                    bindings.bind(object: structInstance, toType: EmptySwiftProtocol.self)
                }
                
                it("should add one binding") {
                    expect(bindings.bindings.count).to(equal(1))
                }
                
                context("the binding") {
                    
                    var binding: ObjectBinding?
                    
                    beforeEach {
                        binding = bindings.bindings["\(EmptySwiftProtocol.self)"] as! ObjectBinding?
                    }
                    
                    it("should contain the instance of struct") {
                        expect(binding?.object as? StructConformingToProtocol).notTo(beNil())
                    }
                    
                }
                
            }
            
        }
        
        describe("bind(closure:, toType:)") {
            
            var closure: ((Injecting) -> AnyObject)!
            
            beforeEach {
                closure = { injector in
                    return ClassConformingToProtocol()
                }
                bindings.bind(type: ClassConformingToProtocol.self, with: closure)
            }
            
            it("should add one binding") {
                expect(bindings.bindings.count).to(equal(1))
            }
            
            context("when binding same closure to another type") {
                
                beforeEach {
                    bindings.bind(type: EmptySwiftProtocol.self, with: closure)
                }
                
                it("should add another binding") {
                    expect(bindings.bindings.count).to(equal(2))
                }
                
            }
            
            context("when adding another closure binding for the same type") {
                
                var otherClosure: ((Injecting) -> AnyObject)!
                var otherClosureCalled = false
                
                beforeEach {
                    otherClosure = { injector in
                        otherClosureCalled = true
                        return ClassConformingToProtocol()
                    }
                    bindings.bind(type: ClassConformingToProtocol.self, with: otherClosure)
                }
                
                afterEach {
                    otherClosureCalled = false
                }
                
                it("should replace the binding") {
                    expect(bindings.bindings.count).to(equal(1))
                }
                
                context("the binding") {
                    
                    var binding: ClosureBinding?
                    
                    beforeEach {
                        binding = bindings.bindings["\(ClassConformingToProtocol.self)"] as! ClosureBinding?
                        _ = binding?.closure(FakeInjector())
                    }
                    
                    it("should contain the other closure") {
                        expect(otherClosureCalled).to(beTrue())
                    }
                    
                }
                
            }
            
        }
        
        describe("bindSingleton<T>(forType:) where T: Creatable") {
            
            beforeEach {
                bindings.bindSingleton(forType: InjectableClass.self)
            }
            
            it("should add one binding") {
                expect(bindings.bindings.count).to(equal(1))
            }
            
            context("when adding another singleton binding for the same type") {
                
                beforeEach {
                    bindings.bindSingleton(forType: InjectableClass.self)
                }
                
                it("should replace the binding") {
                    expect(bindings.bindings.count).to(equal(1))
                }
                
            }
            
        }
        
        describe("bindSingleton<T>(forType:) where T: NSObject") {
            
            beforeEach {
                bindings.bindSingleton(forType: ObjCClass.self)
            }
            
            it("should add one binding") {
                expect(bindings.bindings.count).to(equal(1))
            }
            
            context("when adding another singleton binding for the same type") {
                
                beforeEach {
                    bindings.bindSingleton(forType: ObjCClass.self)
                }
                
                it("should replace the binding") {
                    expect(bindings.bindings.count).to(equal(1))
                }
                
            }
            
        }
        
        describe("bindSingleton<T>(forType:) where T: NSObject, T: Creatable") {
            
            beforeEach {
                bindings.bindSingleton(forType: InjectableObjCClass.self)
            }
            
            it("should add one binding") {
                expect(bindings.bindings.count).to(equal(1))
            }
            
            context("when adding another singleton binding for the same type") {
                
                beforeEach {
                    bindings.bindSingleton(forType: InjectableObjCClass.self)
                }
                
                it("should replace the binding") {
                    expect(bindings.bindings.count).to(equal(1))
                }
                
            }
            
        }
        
        describe("bind<T>(type:, toType:)") {
            
            beforeEach {
                bindings.bind(type: ClassConformingToProtocol.self, toType: EmptySwiftProtocol.self)
            }
            
            it("should add one binding") {
                expect(bindings.bindings.count).to(equal(1))
            }
            
            context("when adding another singleton binding for the same type") {
                
                beforeEach {
                    bindings.bind(type: ClassConformingToProtocol.self, toType: EmptySwiftProtocol.self)
                }
                
                it("should replace the binding") {
                    expect(bindings.bindings.count).to(equal(1))
                }
                
            }
            
        }
        
        describe("bind<T>(type:, toType:) where T: Creatable") {
            
            beforeEach {
                bindings.bind(type: InjectableClass.self, toType: Injectable.self)
            }
            
            it("should add one binding") {
                expect(bindings.bindings.count).to(equal(1))
            }
            
            context("when adding another singleton binding for the same type") {
                
                beforeEach {
                    bindings.bind(type: InjectableClass.self, toType: Injectable.self)
                }
                
                it("should replace the binding") {
                    expect(bindings.bindings.count).to(equal(1))
                }
                
            }
            
        }
        
        describe("bind<T>(type:, toType:) where T: NSObject") {
            
            beforeEach {
                bindings.bind(type: ObjCClass.self, toType: NSObject.self)
            }
            
            it("should add one binding") {
                expect(bindings.bindings.count).to(equal(1))
            }
            
            context("when adding another singleton binding for the same type") {
                
                beforeEach {
                    bindings.bind(type: ObjCClass.self, toType: NSObject.self)
                }
                
                it("should replace the binding") {
                    expect(bindings.bindings.count).to(equal(1))
                }
                
            }
            
        }
        
        describe("bind<T>(type:, toType:) where T: NSObject, T: Creatable") {
            
            beforeEach {
                bindings.bind(type: InjectableObjCClass.self, toType: Injectable.self)
            }
            
            it("should add one binding") {
                expect(bindings.bindings.count).to(equal(1))
            }
            
            context("when adding another singleton binding for the same type") {
                
                beforeEach {
                    bindings.bind(type: InjectableObjCClass.self, toType: Injectable.self)
                }
                
                it("should replace the binding") {
                    expect(bindings.bindings.count).to(equal(1))
                }
                
            }
            
        }
        
        describe("when adding multiple bindings for one type") {
            
            var closureCalled = false
            var object: InjectableClass!
            
            beforeEach {
                object = InjectableClass()
                bindings.bind(object: object, toType: InjectableClass.self)
                bindings.bind(type: InjectableClass.self) { injector in
                    closureCalled = true
                    return object
                }
                bindings.bindSingleton(forType: InjectableClass.self)
            }
            
            afterEach {
                closureCalled = false
            }
            
            it("should have only one binding") {
                expect(bindings.bindings.count).to(equal(1))
            }
            
            context("the binding") {
                
                var binding: Binding?
                var returnedObject: Any?
                
                beforeEach {
                    binding = bindings.bindings["\(InjectableClass.self)"]
                    returnedObject = binding?.getObject(withInjector: FakeInjector())
                }
                
                it("should return newly created object") {
                    expect(returnedObject).notTo(beIdenticalTo(object))
                }
                it("should not call the closure") {
                    expect(closureCalled).to(beFalse())
                }
                
            }
            
        }
        
        describe("subscript(type:)") {
            
            context("when binding for the type exists") {
                
                var objectBinding: Binding?
                var returnedObject: Any?
                
                beforeEach {
                    let object = InjectableClass()
                    objectBinding = ObjectBinding(withObject: object)
                    bindings.bindings = ["\(InjectableClass.self)": objectBinding!]
                    returnedObject = bindings[InjectableClass.self]
                }
                
                it("should return proper object") {
                    expect(returnedObject).to(beIdenticalTo(objectBinding))
                }
                
            }
            
            context("when binding for the type doesn't exist") {
                
                var returnedObject: Any?
                
                beforeEach {
                    returnedObject = bindings[InjectableClass.self]
                }
                
                it("should return nil") {
                    expect(returnedObject).to(beNil())
                }
                
            }
            
        }
        
    }
    
}
