import Quick
import Nimble
@testable import Swifjection

class InjectingSpec: QuickSpec {

    override func spec() {

        var injector: Swifjector!
        var bindings: Bindings!

        beforeEach {
            bindings = Bindings()
            injector = Swifjector(bindings: bindings)
        }
        
        describe("getObject(withType:)") {
            
            context("without any bindings") {
                
                it("should not return object conforming to protocol") {
                    expect(injector.getObject(withType: EmptySwiftProtocol.self)).to(beNil())
                }
                
                it("should not return empty swift object") {
                    expect(injector.getObject(withType: EmptySwiftClass.self)).to(beNil())
                }
                
                it("should return injectable object") {
                    expect(injector.getObject(withType: InjectableClass.self)).notTo(beNil())
                }
                
                it("should inject dependencies in injectable object") {
                    expect(injector.getObject(withType: InjectableClass.self)!.injectDependenciesCalled).to(beTrue())
                }
                
                it("should return injectable ObjC object") {
                    expect(injector.getObject(withType: InjectableObjCClass.self)).to(beAKindOf(InjectableObjCClass.self))
                }
                
                it("should inject dependencies in injectable ObjC object") {
                    expect(injector.getObject(withType: InjectableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
                }
                
                it("should return ObjC object") {
                    expect(injector.getObject(withType: ObjCClass.self)).to(beAKindOf(ObjCClass.self))
                }
                
            }
            
            
            context("with bindings") {
                
                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var injectableObject: InjectableClass?
                var injectableObjCObject: InjectableObjCClass?
                var objCObject: ObjCClass?
                
                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    injectableObject = InjectableClass(injector: injector)
                    injectableObjCObject = InjectableObjCClass(injector: injector)
                    objCObject = ObjCClass()
                }
                
                context("object bindings") {
                    
                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: injectableObject!, toType: InjectableClass.self)
                        bindings.bind(object: injectableObjCObject!, toType: InjectableObjCClass.self)
                        bindings.bind(object: objCObject!, toType: ObjCClass.self)
                    }
                    
                    it("should not have object conforming to protocol injected") {
                        expect(injector.getObject(withType: EmptySwiftProtocol.self)).to(beIdenticalTo(objectConformingToProtocol))
                    }
                    
                    it("should not have empty swift object injected") {
                        expect(injector.getObject(withType: EmptySwiftClass.self)).to(beIdenticalTo(emptySwiftObject))
                    }
                    
                    it("should have injectable object injected") {
                        expect(injector.getObject(withType: InjectableClass.self)).to(beIdenticalTo(injectableObject))
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect(injector.getObject(withType: InjectableClass.self)!.injectDependenciesCalled).to(beFalse())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector.getObject(withType: InjectableObjCClass.self)).to(beIdenticalTo(injectableObjCObject))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect(injector.getObject(withType: InjectableObjCClass.self)!.injectDependenciesCalled).to(beFalse())
                    }
                    
                    it("should have ObjC object injected") {
                        expect(injector.getObject(withType: ObjCClass.self)).to(beIdenticalTo(objCObject))
                    }
                    
                }
                
                context("closure bindings") {
                    
                    beforeEach {
                        injectableObject?.injectDependencies(injector: injector)
                        injectableObjCObject?.injectDependencies(injector: injector)
                        
                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return objectConformingToProtocol!
                        }
                        
                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return emptySwiftObject!
                        }
                        
                        bindings.bind(type: InjectableClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObject!
                        }
                        
                        bindings.bind(type: InjectableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObjCObject!
                        }
                        
                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return objCObject!
                        }
                    }
                    
                    it("should not have object conforming to protocol injected") {
                        expect(injector.getObject(withType: EmptySwiftProtocol.self)).to(beIdenticalTo(objectConformingToProtocol))
                    }
                    
                    it("should not have empty swift object injected") {
                        expect(injector.getObject(withType: EmptySwiftClass.self)).to(beIdenticalTo(emptySwiftObject))
                    }
                    
                    it("should have injectable object injected") {
                        expect(injector.getObject(withType: InjectableClass.self)).to(beIdenticalTo(injectableObject))
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect(injector.getObject(withType: InjectableClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector.getObject(withType: InjectableObjCClass.self)).to(beIdenticalTo(injectableObjCObject))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect(injector.getObject(withType: InjectableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have ObjC object injected") {
                        expect(injector.getObject(withType: ObjCClass.self)).to(beIdenticalTo(objCObject))
                    }
                    
                }
                
                context("closure bindings with new instances") {
                    
                    beforeEach {
                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return ClassConformingToProtocol()
                        }
                        
                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return EmptySwiftClass()
                        }
                        
                        bindings.bind(type: InjectableClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObject = InjectableClass()
                            injectableObject.injectDependencies(injector: injector)
                            return injectableObject
                        }
                        
                        bindings.bind(type: InjectableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObjCObject = InjectableObjCClass()
                            injectableObjCObject.injectDependencies(injector: injector)
                            return injectableObjCObject
                        }
                        
                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return ObjCClass()
                        }
                    }
                    
                    it("should not have object conforming to protocol injected") {
                        expect(injector.getObject(withType: EmptySwiftProtocol.self)).notTo(beNil())
                    }
                    
                    it("should not have empty swift object injected") {
                        expect(injector.getObject(withType: EmptySwiftClass.self)).notTo(beNil())
                    }
                    
                    it("should have injectable object injected") {
                        expect(injector.getObject(withType: InjectableClass.self)).notTo(beNil())
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect(injector.getObject(withType: InjectableClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector.getObject(withType: InjectableObjCClass.self)).to(beAKindOf(InjectableObjCClass.self))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect(injector.getObject(withType: InjectableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have ObjC object injected") {
                        expect(injector.getObject(withType: ObjCClass.self)).to(beAKindOf(ObjCClass.self))
                    }
                    
                }
                
            }
            
        }
        
        describe("subscript") {
            
            context("without any bindings") {
                
                it("should not return object conforming to protocol") {
                    expect(injector[EmptySwiftProtocol.self]).to(beNil())
                }
                
                it("should not return empty swift object") {
                    expect(injector[EmptySwiftClass.self]).to(beNil())
                }
                
                it("should return injectable object") {
                    expect(injector[InjectableClass.self]).notTo(beNil())
                }
                
                it("should inject dependencies in injectable object") {
                    expect((injector[InjectableClass.self]! as! InjectableClass).injectDependenciesCalled).to(beTrue())
                }
                
                it("should return injectable ObjC object") {
                    expect(injector[InjectableObjCClass.self as Injectable.Type]).to(beAKindOf(InjectableObjCClass.self))
                }
                
                it("should inject dependencies in injectable ObjC object") {
                    expect((injector[InjectableObjCClass.self as Injectable.Type]! as! InjectableObjCClass).injectDependenciesCalled).to(beTrue())
                }
                
                it("should return ObjC object") {
                    expect(injector[ObjCClass.self]).to(beAKindOf(ObjCClass.self))
                }
                
            }
            
            
            context("with bindings") {
                
                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var injectableObject: InjectableClass?
                var injectableObjCObject: InjectableObjCClass?
                var objCObject: ObjCClass?
                
                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    injectableObject = InjectableClass(injector: injector)
                    injectableObjCObject = InjectableObjCClass(injector: injector)
                    objCObject = ObjCClass()
                }
                
                context("object bindings") {
                    
                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: injectableObject!, toType: InjectableClass.self)
                        bindings.bind(object: injectableObjCObject!, toType: InjectableObjCClass.self)
                        bindings.bind(object: objCObject!, toType: ObjCClass.self)
                    }
                    
                    it("should not have object conforming to protocol injected") {
                        expect(injector[EmptySwiftProtocol.self]).to(beIdenticalTo(objectConformingToProtocol))
                    }
                    
                    it("should not have empty swift object injected") {
                        expect(injector[EmptySwiftClass.self]).to(beIdenticalTo(emptySwiftObject))
                    }
                    
                    it("should have injectable object injected") {
                        expect(injector[InjectableClass.self]).to(beIdenticalTo(injectableObject))
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect((injector[InjectableClass.self]! as! InjectableClass).injectDependenciesCalled).to(beFalse())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector[InjectableObjCClass.self as Injectable.Type]).to(beIdenticalTo(injectableObjCObject))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect((injector[InjectableObjCClass.self as Injectable.Type]! as! InjectableObjCClass).injectDependenciesCalled).to(beFalse())
                    }
                    
                    it("should have ObjC object injected") {
                        expect(injector[ObjCClass.self]).to(beIdenticalTo(objCObject))
                    }
                    
                }
                
                context("closure bindings") {
                    
                    beforeEach {
                        injectableObject?.injectDependencies(injector: injector)
                        injectableObjCObject?.injectDependencies(injector: injector)
                        
                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return objectConformingToProtocol!
                        }
                        
                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return emptySwiftObject!
                        }
                        
                        bindings.bind(type: InjectableClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObject!
                        }
                        
                        bindings.bind(type: InjectableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObjCObject!
                        }
                        
                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return objCObject!
                        }
                    }
                    
                    it("should not have object conforming to protocol injected") {
                        expect(injector[EmptySwiftProtocol.self]).to(beIdenticalTo(objectConformingToProtocol))
                    }
                    
                    it("should not have empty swift object injected") {
                        expect(injector[EmptySwiftClass.self]).to(beIdenticalTo(emptySwiftObject))
                    }
                    
                    it("should have injectable object injected") {
                        expect(injector[InjectableClass.self]).to(beIdenticalTo(injectableObject))
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect((injector[InjectableClass.self]! as! InjectableClass).injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector[InjectableObjCClass.self as Injectable.Type]).to(beIdenticalTo(injectableObjCObject))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect((injector[InjectableObjCClass.self as Injectable.Type]! as! InjectableObjCClass).injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have ObjC object injected") {
                        expect(injector[ObjCClass.self]).to(beIdenticalTo(objCObject))
                    }
                    
                }
                
                context("closure bindings with new instances") {
                    
                    beforeEach {
                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return ClassConformingToProtocol()
                        }
                        
                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return EmptySwiftClass()
                        }
                        
                        bindings.bind(type: InjectableClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObject = InjectableClass()
                            injectableObject.injectDependencies(injector: injector)
                            return injectableObject
                        }
                        
                        bindings.bind(type: InjectableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObjCObject = InjectableObjCClass()
                            injectableObjCObject.injectDependencies(injector: injector)
                            return injectableObjCObject
                        }
                        
                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return ObjCClass()
                        }
                    }
                    
                    it("should not have object conforming to protocol injected") {
                        expect(injector[EmptySwiftProtocol.self]).notTo(beNil())
                    }
                    
                    it("should not have empty swift object injected") {
                        expect(injector[EmptySwiftClass.self]).notTo(beNil())
                    }
                    
                    it("should have injectable object injected") {
                        expect(injector[InjectableClass.self]).notTo(beNil())
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect((injector[InjectableClass.self]! as! InjectableClass).injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector[InjectableObjCClass.self as Injectable.Type]).to(beAKindOf(InjectableObjCClass.self))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect((injector[InjectableObjCClass.self as Injectable.Type]! as! InjectableObjCClass).injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have ObjC object injected") {
                        expect(injector[ObjCClass.self]).to(beAKindOf(ObjCClass.self))
                    }
                    
                }
                
            }
            
        }

        describe("injecting dependencies in objects using injectDependencies(injector:) with the injector") {

            var objectWithDependencies: ClassWithDependencies!

            context("without any bindings") {

                beforeEach {
                    objectWithDependencies = ClassWithDependencies(injector: injector)
                    objectWithDependencies?.injectDependencies(injector: injector)
                }

                it("should not have object conforming to protocol injected") {
                    expect(objectWithDependencies.objectConformingToProtocol).to(beNil())
                }

                it("should not have empty swift object injected") {
                    expect(objectWithDependencies.emptySwiftObject).to(beNil())
                }

                it("should have injectable object injected") {
                    expect(objectWithDependencies.injectableObject).notTo(beNil())
                }

                it("should inject dependencies in injectable object") {
                    expect(objectWithDependencies.injectableObject!.injectDependenciesCalled).to(beTrue())
                }

                it("should have injectable ObjC object injected") {
                    expect(objectWithDependencies.injectableObjCObject).to(beAKindOf(InjectableObjCClass.self))
                }

                it("should inject dependencies in injectable ObjC object") {
                    expect(objectWithDependencies.injectableObjCObject!.injectDependenciesCalled).to(beTrue())
                }

                it("should have ObjC object injected") {
                    expect(objectWithDependencies.objCObject).to(beAKindOf(ObjCClass.self))
                }

            }

            context("with bindings") {

                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var injectableObject: InjectableClass?
                var injectableObjCObject: InjectableObjCClass?
                var objCObject: ObjCClass?

                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    injectableObject = InjectableClass(injector: injector)
                    injectableObjCObject = InjectableObjCClass(injector: injector)
                    objCObject = ObjCClass()
                }

                context("object bindings") {

                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: injectableObject!, toType: InjectableClass.self)
                        bindings.bind(object: injectableObjCObject!, toType: InjectableObjCClass.self)
                        bindings.bind(object: objCObject!, toType: ObjCClass.self)

                        objectWithDependencies = ClassWithDependencies(injector: injector)
                        objectWithDependencies?.injectDependencies(injector: injector)
                    }

                    it("should not have object conforming to protocol injected") {
                        expect(objectWithDependencies.objectConformingToProtocol).to(beIdenticalTo(objectConformingToProtocol))
                    }

                    it("should not have empty swift object injected") {
                        expect(objectWithDependencies.emptySwiftObject).to(beIdenticalTo(emptySwiftObject))
                    }

                    it("should have injectable object injected") {
                        expect(objectWithDependencies.injectableObject).to(beIdenticalTo(injectableObject))
                    }

                    it("should inject dependencies in injectable object") {
                        expect(objectWithDependencies.injectableObject!.injectDependenciesCalled).to(beFalse())
                    }

                    it("should have injectable ObjC object injected") {
                        expect(objectWithDependencies.injectableObjCObject).to(beIdenticalTo(injectableObjCObject))
                    }

                    it("should inject dependencies in injectable ObjC object") {
                        expect(objectWithDependencies.injectableObjCObject!.injectDependenciesCalled).to(beFalse())
                    }

                    it("should have ObjC object injected") {
                        expect(objectWithDependencies.objCObject).to(beIdenticalTo(objCObject))
                    }

                }

                context("closure bindings") {

                    beforeEach {
                        injectableObject?.injectDependencies(injector: injector)
                        injectableObjCObject?.injectDependencies(injector: injector)

                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return objectConformingToProtocol!
                        }

                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return emptySwiftObject!
                        }

                        bindings.bind(type: InjectableClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObject!
                        }

                        bindings.bind(type: InjectableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObjCObject!
                        }

                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return objCObject!
                        }

                        objectWithDependencies = ClassWithDependencies(injector: injector)
                        objectWithDependencies?.injectDependencies(injector: injector)
                    }

                    it("should not have object conforming to protocol injected") {
                        expect(objectWithDependencies.objectConformingToProtocol).to(beIdenticalTo(objectConformingToProtocol))
                    }

                    it("should not have empty swift object injected") {
                        expect(objectWithDependencies.emptySwiftObject).to(beIdenticalTo(emptySwiftObject))
                    }

                    it("should have injectable object injected") {
                        expect(objectWithDependencies.injectableObject).to(beIdenticalTo(injectableObject))
                    }

                    it("should inject dependencies in injectable object") {
                        expect(objectWithDependencies.injectableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have injectable ObjC object injected") {
                        expect(objectWithDependencies.injectableObjCObject).to(beIdenticalTo(injectableObjCObject))
                    }

                    it("should inject dependencies in injectable ObjC object") {
                        expect(objectWithDependencies.injectableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have ObjC object injected") {
                        expect(objectWithDependencies.objCObject).to(beIdenticalTo(objCObject))
                    }

                }

                context("closure bindings with new instances") {

                    beforeEach {
                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return ClassConformingToProtocol()
                        }

                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return EmptySwiftClass()
                        }

                        bindings.bind(type: InjectableClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObject = InjectableClass()
                            injectableObject.injectDependencies(injector: injector)
                            return injectableObject
                        }

                        bindings.bind(type: InjectableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObjCObject = InjectableObjCClass()
                            injectableObjCObject.injectDependencies(injector: injector)
                            return injectableObjCObject
                        }

                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return ObjCClass()
                        }

                        objectWithDependencies = ClassWithDependencies(injector: injector)
                        objectWithDependencies?.injectDependencies(injector: injector)
                    }

                    it("should not have object conforming to protocol injected") {
                        expect(objectWithDependencies.objectConformingToProtocol).notTo(beNil())
                    }

                    it("should not have empty swift object injected") {
                        expect(objectWithDependencies.emptySwiftObject).notTo(beNil())
                    }

                    it("should have injectable object injected") {
                        expect(objectWithDependencies.injectableObject).notTo(beNil())
                    }

                    it("should inject dependencies in injectable object") {
                        expect(objectWithDependencies.injectableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have injectable ObjC object injected") {
                        expect(objectWithDependencies.injectableObjCObject).to(beAKindOf(InjectableObjCClass.self))
                    }

                    it("should inject dependencies in injectable ObjC object") {
                        expect(objectWithDependencies.injectableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have ObjC object injected") {
                        expect(objectWithDependencies.objCObject).to(beAKindOf(ObjCClass.self))
                    }

                }

            }

        }

    }

}
