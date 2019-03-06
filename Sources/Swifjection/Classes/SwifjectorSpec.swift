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
                    expect(injector.getObject(withType: CreatableClass.self)).notTo(beNil())
                }
                
                it("should inject dependencies in injectable object") {
                    expect(injector.getObject(withType: CreatableClass.self)!.injectDependenciesCalled).to(beTrue())
                }
                
                it("should return injectable ObjC object") {
                    expect(injector.getObject(withType: CreatableObjCClass.self)).to(beAKindOf(CreatableObjCClass.self))
                }
                
                it("should inject dependencies in injectable ObjC object") {
                    expect(injector.getObject(withType: CreatableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
                }
                
                it("should return ObjC object") {
                    expect(injector.getObject(withType: ObjCClass.self)).to(beAKindOf(ObjCClass.self))
                }
                
            }

            context("with bindings with implicitly unwrapped objects") {
                var objectConformingToProtocol: ClassConformingToProtocol!
                var structConformingToProtocol: StructConformingToProtocol!
                var emptySwiftObject: EmptySwiftClass!
                var injectableObject: CreatableClass!
                var injectableObjCObject: CreatableObjCClass!
                var objCObject: ObjCClass!
                
                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    structConformingToProtocol = StructConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    injectableObject = CreatableClass()
                    injectableObjCObject = CreatableObjCClass()
                    objCObject = ObjCClass()
                }
                
                context("for object conforming to protocol") {
                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol, toType: EmptySwiftProtocol.self)
                    }
                    it("should have object conforming to protocol injected") {
                        let object = injector.getObject(withType: EmptySwiftProtocol.self)
                        expect(object).to(beIdenticalTo(objectConformingToProtocol))
                    }
                }
                context("for struct conforming to protocol") {
                    beforeEach {
                        bindings.bind(object: structConformingToProtocol, toType: EmptySwiftProtocol.self)
                    }
                    it("should have struct conforming to protocol injected") {
                        let object = injector.getObject(withType: EmptySwiftProtocol.self)
                        expect(object).to(beAnInstanceOf(StructConformingToProtocol.self))
                    }
                }
                context("for other cases") {
                    beforeEach {
                        bindings.bind(object: emptySwiftObject, toType: EmptySwiftClass.self)
                        bindings.bind(object: injectableObject, toType: CreatableClass.self)
                        bindings.bind(object: injectableObjCObject, toType: CreatableObjCClass.self)
                        bindings.bind(object: objCObject, toType: ObjCClass.self)
                    }
                    it("should have empty swift object injected") {
                        expect(injector.getObject(withType: EmptySwiftClass.self)).to(beIdenticalTo(emptySwiftObject))
                    }
                    it("should have injectable object injected") {
                        expect(injector.getObject(withType: CreatableClass.self)).to(beIdenticalTo(injectableObject))
                    }
                    it("should inject dependencies in injectable object") {
                        expect(injector.getObject(withType: CreatableClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    it("should have injectable ObjC object injected") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)).to(beIdenticalTo(injectableObjCObject))
                    }
                    it("should inject dependencies in injectable ObjC object") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    it("should have ObjC object injected") {
                        expect(injector.getObject(withType: ObjCClass.self)).to(beIdenticalTo(objCObject))
                    }
                }
            }
            
            context("with bindings") {
                
                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var injectableObject: CreatableClass?
                var injectableObjCObject: CreatableObjCClass?
                var objCObject: ObjCClass?
                
                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    injectableObject = CreatableClass()
                    injectableObjCObject = CreatableObjCClass()
                    objCObject = ObjCClass()
                }
                
                context("object bindings") {
                    
                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: injectableObject!, toType: CreatableClass.self)
                        bindings.bind(object: injectableObjCObject!, toType: CreatableObjCClass.self)
                        bindings.bind(object: objCObject!, toType: ObjCClass.self)
                    }
                    
                    it("should have object conforming to protocol injected") {
                        expect(injector.getObject(withType: EmptySwiftProtocol.self)).to(beIdenticalTo(objectConformingToProtocol))
                    }
                    
                    it("should have empty swift object injected") {
                        expect(injector.getObject(withType: EmptySwiftClass.self)).to(beIdenticalTo(emptySwiftObject))
                    }
                    
                    it("should have injectable object injected") {
                        expect(injector.getObject(withType: CreatableClass.self)).to(beIdenticalTo(injectableObject))
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect(injector.getObject(withType: CreatableClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)).to(beIdenticalTo(injectableObjCObject))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
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
                        
                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObject!
                        }
                        
                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
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
                        expect(injector.getObject(withType: CreatableClass.self)).to(beIdenticalTo(injectableObject))
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect(injector.getObject(withType: CreatableClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)).to(beIdenticalTo(injectableObjCObject))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
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
                        
                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObject = CreatableClass()
                            injectableObject.injectDependencies(injector: injector)
                            return injectableObject
                        }
                        
                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObjCObject = CreatableObjCClass()
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
                        expect(injector.getObject(withType: CreatableClass.self)).notTo(beNil())
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect(injector.getObject(withType: CreatableClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)).to(beAKindOf(CreatableObjCClass.self))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
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
                    expect(injector[CreatableClass.self]).notTo(beNil())
                }
                
                it("should inject dependencies in injectable object") {
                    expect((injector[CreatableClass.self]! as! CreatableClass).injectDependenciesCalled).to(beTrue())
                }
                
                it("should return injectable ObjC object") {
                    let injector = injector!
                    let object = injector[CreatableObjCClass.self as Creatable.Type]
                    expect(object).to(beAKindOf(CreatableObjCClass.self))
                }
                
                it("should inject dependencies in injectable ObjC object") {
                    expect((injector[CreatableObjCClass.self as Creatable.Type]! as! CreatableObjCClass).injectDependenciesCalled).to(beTrue())
                }
                
                it("should return ObjC object") {
                    expect(injector[ObjCClass.self]).to(beAKindOf(ObjCClass.self))
                }
                
            }
            
            
            context("with bindings") {
                
                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var injectableObject: CreatableClass?
                var injectableObjCObject: CreatableObjCClass?
                var objCObject: ObjCClass?
                
                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    injectableObject = CreatableClass()
                    injectableObjCObject = CreatableObjCClass()
                    objCObject = ObjCClass()
                }
                
                context("object bindings") {
                    
                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: injectableObject!, toType: CreatableClass.self)
                        bindings.bind(object: injectableObjCObject!, toType: CreatableObjCClass.self)
                        bindings.bind(object: objCObject!, toType: ObjCClass.self)
                    }
                    
                    it("should not have object conforming to protocol injected") {
                        expect(injector[EmptySwiftProtocol.self]).to(beIdenticalTo(objectConformingToProtocol))
                    }
                    
                    it("should not have empty swift object injected") {
                        expect(injector[EmptySwiftClass.self]).to(beIdenticalTo(emptySwiftObject))
                    }
                    
                    it("should have injectable object injected") {
                        expect(injector[CreatableClass.self]).to(beIdenticalTo(injectableObject))
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect((injector[CreatableClass.self]! as! CreatableClass).injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector[CreatableObjCClass.self as Creatable.Type]).to(beIdenticalTo(injectableObjCObject))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect((injector[CreatableObjCClass.self as Creatable.Type]! as! CreatableObjCClass).injectDependenciesCalled).to(beTrue())
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
                        
                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObject!
                        }
                        
                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
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
                        expect(injector[CreatableClass.self]).to(beIdenticalTo(injectableObject))
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect((injector[CreatableClass.self]! as! CreatableClass).injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector[CreatableObjCClass.self as Creatable.Type]).to(beIdenticalTo(injectableObjCObject))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect((injector[CreatableObjCClass.self as Creatable.Type]! as! CreatableObjCClass).injectDependenciesCalled).to(beTrue())
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
                        
                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObject = CreatableClass()
                            injectableObject.injectDependencies(injector: injector)
                            return injectableObject
                        }
                        
                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObjCObject = CreatableObjCClass()
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
                        expect(injector[CreatableClass.self]).notTo(beNil())
                    }
                    
                    it("should inject dependencies in injectable object") {
                        expect((injector[CreatableClass.self]! as! CreatableClass).injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have injectable ObjC object injected") {
                        expect(injector[CreatableObjCClass.self as Creatable.Type]).to(beAKindOf(CreatableObjCClass.self))
                    }
                    
                    it("should inject dependencies in injectable ObjC object") {
                        expect((injector[CreatableObjCClass.self as Creatable.Type]! as! CreatableObjCClass).injectDependenciesCalled).to(beTrue())
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
                    objectWithDependencies = ClassWithDependencies()
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
                    expect(objectWithDependencies.injectableObjCObject).to(beAKindOf(CreatableObjCClass.self))
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
                var injectableObject: CreatableClass?
                var injectableObjCObject: CreatableObjCClass?
                var objCObject: ObjCClass?

                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    injectableObject = CreatableClass()
                    injectableObjCObject = CreatableObjCClass()
                    objCObject = ObjCClass()
                }

                context("object bindings") {

                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: injectableObject!, toType: CreatableClass.self)
                        bindings.bind(object: injectableObjCObject!, toType: CreatableObjCClass.self)
                        bindings.bind(object: objCObject!, toType: ObjCClass.self)

                        objectWithDependencies = ClassWithDependencies()
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

                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObject!
                        }

                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObjCObject!
                        }

                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return objCObject!
                        }

                        objectWithDependencies = ClassWithDependencies()
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

                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObject = CreatableClass()
                            injectableObject.injectDependencies(injector: injector)
                            return injectableObject
                        }

                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObjCObject = CreatableObjCClass()
                            injectableObjCObject.injectDependencies(injector: injector)
                            return injectableObjCObject
                        }

                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return ObjCClass()
                        }

                        objectWithDependencies = ClassWithDependencies()
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
                        expect(objectWithDependencies.injectableObjCObject).to(beAKindOf(CreatableObjCClass.self))
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

        describe("injecting dependencies in objects using injectDependencies(injector:) with the injector") {

            var automaticallyInjectableObject: AutoInjectableClass!

            context("without any bindings") {

                beforeEach {
                    automaticallyInjectableObject = AutoInjectableClass()
                    automaticallyInjectableObject?.injectDependencies(injector: injector)
                }

                it("should not have object conforming to protocol injected") {
                    expect(automaticallyInjectableObject.objectConformingToProtocol).to(beNil())
                }

                it("should not have empty swift object injected") {
                    expect(automaticallyInjectableObject.emptySwiftObject).to(beNil())
                }

                it("should have injectable object injected") {
                    expect(automaticallyInjectableObject.injectableObject).notTo(beNil())
                }

                it("should inject dependencies in injectable object") {
                    expect(automaticallyInjectableObject.injectableObject!.injectDependenciesCalled).to(beTrue())
                }

                it("should have injectable ObjC object injected") {
                    expect(automaticallyInjectableObject.injectableObjCObject).to(beAKindOf(CreatableObjCClass.self))
                }

                it("should inject dependencies in injectable ObjC object") {
                    expect(automaticallyInjectableObject.injectableObjCObject!.injectDependenciesCalled).to(beTrue())
                }

                it("should have ObjC object injected") {
                    expect(automaticallyInjectableObject.objCObject).to(beAKindOf(ObjCClass.self))
                }

            }

            context("with bindings") {

                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var injectableObject: CreatableClass?
                var injectableObjCObject: CreatableObjCClass?
                var objCObject: ObjCClass?

                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    injectableObject = CreatableClass()
                    injectableObjCObject = CreatableObjCClass()
                    objCObject = ObjCClass()
                }

                context("object bindings") {

                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: injectableObject!, toType: CreatableClass.self)
                        bindings.bind(object: injectableObjCObject!, toType: CreatableObjCClass.self)
                        bindings.bind(object: objCObject!, toType: ObjCClass.self)

                        automaticallyInjectableObject = AutoInjectableClass()
                        automaticallyInjectableObject?.injectDependencies(injector: injector)
                    }

                    it("should not have object conforming to protocol injected") {
                        expect(automaticallyInjectableObject.objectConformingToProtocol).to(beIdenticalTo(objectConformingToProtocol))
                    }

                    it("should not have empty swift object injected") {
                        expect(automaticallyInjectableObject.emptySwiftObject).to(beIdenticalTo(emptySwiftObject))
                    }

                    it("should have injectable object injected") {
                        expect(automaticallyInjectableObject.injectableObject).to(beIdenticalTo(injectableObject))
                    }

                    it("should inject dependencies in injectable object") {
                        expect(automaticallyInjectableObject.injectableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have injectable ObjC object injected") {
                        expect(automaticallyInjectableObject.injectableObjCObject).to(beIdenticalTo(injectableObjCObject))
                    }

                    it("should inject dependencies in injectable ObjC object") {
                        expect(automaticallyInjectableObject.injectableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have ObjC object injected") {
                        expect(automaticallyInjectableObject.objCObject).to(beIdenticalTo(objCObject))
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

                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObject!
                        }

                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return injectableObjCObject!
                        }

                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return objCObject!
                        }

                        automaticallyInjectableObject = AutoInjectableClass()
                        automaticallyInjectableObject?.injectDependencies(injector: injector)
                    }

                    it("should not have object conforming to protocol injected") {
                        expect(automaticallyInjectableObject.objectConformingToProtocol).to(beIdenticalTo(objectConformingToProtocol))
                    }

                    it("should not have empty swift object injected") {
                        expect(automaticallyInjectableObject.emptySwiftObject).to(beIdenticalTo(emptySwiftObject))
                    }

                    it("should have injectable object injected") {
                        expect(automaticallyInjectableObject.injectableObject).to(beIdenticalTo(injectableObject))
                    }

                    it("should inject dependencies in injectable object") {
                        expect(automaticallyInjectableObject.injectableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have injectable ObjC object injected") {
                        expect(automaticallyInjectableObject.injectableObjCObject).to(beIdenticalTo(injectableObjCObject))
                    }

                    it("should inject dependencies in injectable ObjC object") {
                        expect(automaticallyInjectableObject.injectableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have ObjC object injected") {
                        expect(automaticallyInjectableObject.objCObject).to(beIdenticalTo(objCObject))
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

                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObject = CreatableClass()
                            injectableObject.injectDependencies(injector: injector)
                            return injectableObject
                        }

                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let injectableObjCObject = CreatableObjCClass()
                            injectableObjCObject.injectDependencies(injector: injector)
                            return injectableObjCObject
                        }

                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return ObjCClass()
                        }

                        automaticallyInjectableObject = AutoInjectableClass()
                        automaticallyInjectableObject?.injectDependencies(injector: injector)
                    }

                    it("should not have object conforming to protocol injected") {
                        expect(automaticallyInjectableObject.objectConformingToProtocol).notTo(beNil())
                    }

                    it("should not have empty swift object injected") {
                        expect(automaticallyInjectableObject.emptySwiftObject).notTo(beNil())
                    }

                    it("should have injectable object injected") {
                        expect(automaticallyInjectableObject.injectableObject).notTo(beNil())
                    }

                    it("should inject dependencies in injectable object") {
                        expect(automaticallyInjectableObject.injectableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have injectable ObjC object injected") {
                        expect(automaticallyInjectableObject.injectableObjCObject).to(beAKindOf(CreatableObjCClass.self))
                    }

                    it("should inject dependencies in injectable ObjC object") {
                        expect(automaticallyInjectableObject.injectableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have ObjC object injected") {
                        expect(automaticallyInjectableObject.objCObject).to(beAKindOf(ObjCClass.self))
                    }

                }

            }

        }

    }

}
