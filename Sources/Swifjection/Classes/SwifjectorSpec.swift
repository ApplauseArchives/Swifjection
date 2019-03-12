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
                
                it("should return creatable object") {
                    expect(injector.getObject(withType: CreatableClass.self)).notTo(beNil())
                }
                
                it("should inject dependencies in creatable object") {
                    expect(injector.getObject(withType: CreatableClass.self)!.injectDependenciesCalled).to(beTrue())
                }
                
                it("should return creatable ObjC object") {
                    expect(injector.getObject(withType: CreatableObjCClass.self)).to(beAKindOf(CreatableObjCClass.self))
                }
                
                it("should inject dependencies in creatable ObjC object") {
                    expect(injector.getObject(withType: CreatableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
                }

                it("should return inject-creatable ObjC object") {
                    expect(injector.getObject(withType: InjectCreatableObjCClass.self)).to(beAKindOf(InjectCreatableObjCClass.self))
                }

                it("should init inject-creatable ObjC object with injector") {
                    expect(injector.getObject(withType: InjectCreatableObjCClass.self)!.initWithInjectorCalled).to(beTrue())
                }
                
                it("should return ObjC object") {
                    expect(injector.getObject(withType: ObjCClass.self)).to(beAKindOf(ObjCClass.self))
                }
                
            }

            context("with bindings with implicitly unwrapped objects") {
                var objectConformingToProtocol: ClassConformingToProtocol!
                var structConformingToProtocol: StructConformingToProtocol!
                var emptySwiftObject: EmptySwiftClass!
                var creatableObject: CreatableClass!
                var creatableObjCObject: CreatableObjCClass!
                var injectCreatableObjCObject: InjectCreatableObjCClass!
                var objCObject: ObjCClass!
                
                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    structConformingToProtocol = StructConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    creatableObject = CreatableClass()
                    creatableObjCObject = CreatableObjCClass()
                    injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
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
                        bindings.bind(object: creatableObject, toType: CreatableClass.self)
                        bindings.bind(object: creatableObjCObject, toType: CreatableObjCClass.self)
                        bindings.bind(object: injectCreatableObjCObject, toType: InjectCreatableObjCClass.self)
                        bindings.bind(object: objCObject, toType: ObjCClass.self)
                    }
                    it("should have empty swift object injected") {
                        expect(injector.getObject(withType: EmptySwiftClass.self)).to(beIdenticalTo(emptySwiftObject))
                    }
                    it("should have creatable object injected") {
                        expect(injector.getObject(withType: CreatableClass.self)).to(beIdenticalTo(creatableObject))
                    }
                    it("should inject dependencies in creatable object") {
                        expect(injector.getObject(withType: CreatableClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    it("should have creatable ObjC object injected") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)).to(beIdenticalTo(creatableObjCObject))
                    }
                    it("should inject dependencies in creatable ObjC object") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    it("should have inject-creatable ObjC object injected") {
                        expect(injector.getObject(withType: InjectCreatableObjCClass.self)).to(beIdenticalTo(injectCreatableObjCObject))
                    }
                    it("should have ObjC object injected") {
                        expect(injector.getObject(withType: ObjCClass.self)).to(beIdenticalTo(objCObject))
                    }
                }
            }
            
            context("with bindings") {
                
                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var creatableObject: CreatableClass?
                var creatableObjCObject: CreatableObjCClass?
                var injectCreatableObjCObject: InjectCreatableObjCClass?
                var objCObject: ObjCClass?
                
                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    creatableObject = CreatableClass()
                    creatableObjCObject = CreatableObjCClass()
                    injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
                    objCObject = ObjCClass()
                }
                
                context("object bindings") {
                    
                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: creatableObject!, toType: CreatableClass.self)
                        bindings.bind(object: creatableObjCObject!, toType: CreatableObjCClass.self)
                        bindings.bind(object: injectCreatableObjCObject!, toType: InjectCreatableObjCClass.self)
                        bindings.bind(object: objCObject!, toType: ObjCClass.self)
                    }
                    
                    it("should have object conforming to protocol injected") {
                        expect(injector.getObject(withType: EmptySwiftProtocol.self)).to(beIdenticalTo(objectConformingToProtocol))
                    }
                    
                    it("should have empty swift object injected") {
                        expect(injector.getObject(withType: EmptySwiftClass.self)).to(beIdenticalTo(emptySwiftObject))
                    }
                    
                    it("should have creatable object injected") {
                        expect(injector.getObject(withType: CreatableClass.self)).to(beIdenticalTo(creatableObject))
                    }
                    
                    it("should inject dependencies in creatable object") {
                        expect(injector.getObject(withType: CreatableClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have creatable ObjC object injected") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)).to(beIdenticalTo(creatableObjCObject))
                    }
                    
                    it("should inject dependencies in creatable ObjC object") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(injector.getObject(withType: InjectCreatableObjCClass.self)).to(beIdenticalTo(injectCreatableObjCObject))
                    }
                    
                    it("should have ObjC object injected") {
                        expect(injector.getObject(withType: ObjCClass.self)).to(beIdenticalTo(objCObject))
                    }
                    
                }
                
                context("closure bindings") {
                    
                    beforeEach {
                        creatableObject?.injectDependencies(injector: injector)
                        creatableObjCObject?.injectDependencies(injector: injector)
                        
                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return objectConformingToProtocol!
                        }
                        
                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return emptySwiftObject!
                        }
                        
                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            return creatableObject!
                        }
                        
                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return creatableObjCObject!
                        }

                        bindings.bind(type: InjectCreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return injectCreatableObjCObject!
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
                    
                    it("should have creatable object injected") {
                        expect(injector.getObject(withType: CreatableClass.self)).to(beIdenticalTo(creatableObject))
                    }
                    
                    it("should inject dependencies in creatable object") {
                        expect(injector.getObject(withType: CreatableClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have creatable ObjC object injected") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)).to(beIdenticalTo(creatableObjCObject))
                    }
                    
                    it("should inject dependencies in creatable ObjC object") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(injector.getObject(withType: InjectCreatableObjCClass.self)).to(beIdenticalTo(injectCreatableObjCObject))
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
                            let creatableObject = CreatableClass()
                            creatableObject.injectDependencies(injector: injector)
                            return creatableObject
                        }
                        
                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let creatableObjCObject = CreatableObjCClass()
                            creatableObjCObject.injectDependencies(injector: injector)
                            return creatableObjCObject
                        }

                        bindings.bind(type: InjectCreatableObjCClass.self) { (injector: Injecting) -> AnyObject? in
                            let injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
                            return injectCreatableObjCObject
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
                    
                    it("should have creatable object injected") {
                        expect(injector.getObject(withType: CreatableClass.self)).notTo(beNil())
                    }
                    
                    it("should inject dependencies in creatable object") {
                        expect(injector.getObject(withType: CreatableClass.self)!.injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have creatable ObjC object injected") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)).to(beAKindOf(CreatableObjCClass.self))
                    }
                    
                    it("should inject dependencies in creatable ObjC object") {
                        expect(injector.getObject(withType: CreatableObjCClass.self)!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(injector.getObject(withType: InjectCreatableObjCClass.self)).to(beAKindOf(InjectCreatableObjCClass.self))
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
                
                it("should return creatable object") {
                    expect(injector[CreatableClass.self]).notTo(beNil())
                }
                
                it("should inject dependencies in creatable object") {
                    expect((injector[CreatableClass.self]! as! CreatableClass).injectDependenciesCalled).to(beTrue())
                }
                
                it("should return creatable ObjC object") {
                    let injector = injector!
                    let object = injector[CreatableObjCClass.self as Creatable.Type]
                    expect(object).to(beAKindOf(CreatableObjCClass.self))
                }
                
                it("should inject dependencies in creatable ObjC object") {
                    expect((injector[CreatableObjCClass.self as Creatable.Type]! as! CreatableObjCClass).injectDependenciesCalled).to(beTrue())
                }

                it("should return inject-creatable ObjC object") {
                    let injector = injector!
                    let object = injector[InjectCreatableObjCClass.self as InjectCreatable.Type]
                    expect(object).to(beAKindOf(InjectCreatableObjCClass.self))
                }
                
                it("should return ObjC object") {
                    expect(injector[ObjCClass.self]).to(beAKindOf(ObjCClass.self))
                }
                
            }
            
            
            context("with bindings") {
                
                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var creatableObject: CreatableClass?
                var creatableObjCObject: CreatableObjCClass?
                var injectCreatableObjCObject: InjectCreatableObjCClass?
                var objCObject: ObjCClass?
                
                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    creatableObject = CreatableClass()
                    creatableObjCObject = CreatableObjCClass()
                    injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
                    objCObject = ObjCClass()
                }
                
                context("object bindings") {
                    
                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: creatableObject!, toType: CreatableClass.self)
                        bindings.bind(object: creatableObjCObject!, toType: CreatableObjCClass.self)
                        bindings.bind(object: injectCreatableObjCObject!, toType: InjectCreatableObjCClass.self)
                        bindings.bind(object: objCObject!, toType: ObjCClass.self)
                    }
                    
                    it("should not have object conforming to protocol injected") {
                        expect(injector[EmptySwiftProtocol.self]).to(beIdenticalTo(objectConformingToProtocol))
                    }
                    
                    it("should not have empty swift object injected") {
                        expect(injector[EmptySwiftClass.self]).to(beIdenticalTo(emptySwiftObject))
                    }
                    
                    it("should have creatable object injected") {
                        expect(injector[CreatableClass.self]).to(beIdenticalTo(creatableObject))
                    }
                    
                    it("should inject dependencies in creatable object") {
                        expect((injector[CreatableClass.self]! as! CreatableClass).injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have creatable ObjC object injected") {
                        expect(injector[CreatableObjCClass.self as Creatable.Type]).to(beIdenticalTo(creatableObjCObject))
                    }
                    
                    it("should inject dependencies in creatable ObjC object") {
                        expect((injector[CreatableObjCClass.self as Creatable.Type]! as! CreatableObjCClass).injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(injector[InjectCreatableObjCClass.self as InjectCreatable.Type]).to(beIdenticalTo(injectCreatableObjCObject))
                    }
                    
                    it("should have ObjC object injected") {
                        expect(injector[ObjCClass.self]).to(beIdenticalTo(objCObject))
                    }
                    
                }
                
                context("closure bindings") {
                    
                    beforeEach {
                        creatableObject?.injectDependencies(injector: injector)
                        creatableObjCObject?.injectDependencies(injector: injector)
                        
                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return objectConformingToProtocol!
                        }
                        
                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return emptySwiftObject!
                        }
                        
                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            return creatableObject!
                        }
                        
                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return creatableObjCObject!
                        }

                        bindings.bind(type: InjectCreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return injectCreatableObjCObject!
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
                    
                    it("should have creatable object injected") {
                        expect(injector[CreatableClass.self]).to(beIdenticalTo(creatableObject))
                    }
                    
                    it("should inject dependencies in creatable object") {
                        expect((injector[CreatableClass.self]! as! CreatableClass).injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have creatable ObjC object injected") {
                        expect(injector[CreatableObjCClass.self as Creatable.Type]).to(beIdenticalTo(creatableObjCObject))
                    }
                    
                    it("should inject dependencies in creatable ObjC object") {
                        expect((injector[CreatableObjCClass.self as Creatable.Type]! as! CreatableObjCClass).injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(injector[InjectCreatableObjCClass.self as InjectCreatable.Type]).to(beIdenticalTo(injectCreatableObjCObject))
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
                            let creatableObject = CreatableClass()
                            creatableObject.injectDependencies(injector: injector)
                            return creatableObject
                        }
                        
                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let creatableObjCObject = CreatableObjCClass()
                            creatableObjCObject.injectDependencies(injector: injector)
                            return creatableObjCObject
                        }

                        bindings.bind(type: InjectCreatableObjCClass.self) { (injector: Injecting) -> AnyObject? in
                            let injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
                            return injectCreatableObjCObject
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
                    
                    it("should have creatable object injected") {
                        expect(injector[CreatableClass.self]).notTo(beNil())
                    }
                    
                    it("should inject dependencies in creatable object") {
                        expect((injector[CreatableClass.self]! as! CreatableClass).injectDependenciesCalled).to(beTrue())
                    }
                    
                    it("should have creatable ObjC object injected") {
                        expect(injector[CreatableObjCClass.self as Creatable.Type]).to(beAKindOf(CreatableObjCClass.self))
                    }
                    
                    it("should inject dependencies in creatable ObjC object") {
                        expect((injector[CreatableObjCClass.self as Creatable.Type]! as! CreatableObjCClass).injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(injector[InjectCreatableObjCClass.self as InjectCreatable.Type]).to(beAKindOf(InjectCreatableObjCClass.self))
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

                it("should have creatable object injected") {
                    expect(objectWithDependencies.creatableObject).notTo(beNil())
                }

                it("should inject dependencies in creatable object") {
                    expect(objectWithDependencies.creatableObject!.injectDependenciesCalled).to(beTrue())
                }

                it("should have creatable ObjC object injected") {
                    expect(objectWithDependencies.creatableObjCObject).to(beAKindOf(CreatableObjCClass.self))
                }

                it("should inject dependencies in creatable ObjC object") {
                    expect(objectWithDependencies.creatableObjCObject!.injectDependenciesCalled).to(beTrue())
                }

                it("should have inject-creatable ObjC object injected") {
                    expect(objectWithDependencies.injectCreatableObjCObject).to(beAKindOf(InjectCreatableObjCClass.self))
                }

                it("should have ObjC object injected") {
                    expect(objectWithDependencies.objCObject).to(beAKindOf(ObjCClass.self))
                }

            }

            context("with bindings") {

                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var creatableObject: CreatableClass?
                var creatableObjCObject: CreatableObjCClass?
                var injectCreatableObjCObject: InjectCreatableObjCClass?
                var objCObject: ObjCClass?

                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    creatableObject = CreatableClass()
                    creatableObjCObject = CreatableObjCClass()
                    injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
                    objCObject = ObjCClass()
                }

                context("object bindings") {

                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: creatableObject!, toType: CreatableClass.self)
                        bindings.bind(object: creatableObjCObject!, toType: CreatableObjCClass.self)
                        bindings.bind(object: injectCreatableObjCObject!, toType: InjectCreatableObjCClass.self)
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

                    it("should have creatable object injected") {
                        expect(objectWithDependencies.creatableObject).to(beIdenticalTo(creatableObject))
                    }

                    it("should inject dependencies in creatable object") {
                        expect(objectWithDependencies.creatableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have creatable ObjC object injected") {
                        expect(objectWithDependencies.creatableObjCObject).to(beIdenticalTo(creatableObjCObject))
                    }

                    it("should inject dependencies in creatable ObjC object") {
                        expect(objectWithDependencies.creatableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(objectWithDependencies.injectCreatableObjCObject).to(beIdenticalTo(injectCreatableObjCObject))
                    }

                    it("should have ObjC object injected") {
                        expect(objectWithDependencies.objCObject).to(beIdenticalTo(objCObject))
                    }

                }

                context("closure bindings") {

                    beforeEach {
                        creatableObject?.injectDependencies(injector: injector)
                        creatableObjCObject?.injectDependencies(injector: injector)

                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return objectConformingToProtocol!
                        }

                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return emptySwiftObject!
                        }

                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            return creatableObject!
                        }

                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return creatableObjCObject!
                        }

                        bindings.bind(type: InjectCreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return injectCreatableObjCObject!
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

                    it("should have creatable object injected") {
                        expect(objectWithDependencies.creatableObject).to(beIdenticalTo(creatableObject))
                    }

                    it("should inject dependencies in creatable object") {
                        expect(objectWithDependencies.creatableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have creatable ObjC object injected") {
                        expect(objectWithDependencies.creatableObjCObject).to(beIdenticalTo(creatableObjCObject))
                    }

                    it("should inject dependencies in creatable ObjC object") {
                        expect(objectWithDependencies.creatableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(objectWithDependencies.injectCreatableObjCObject).to(beIdenticalTo(injectCreatableObjCObject))
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
                            let creatableObject = CreatableClass()
                            creatableObject.injectDependencies(injector: injector)
                            return creatableObject
                        }

                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let creatableObjCObject = CreatableObjCClass()
                            creatableObjCObject.injectDependencies(injector: injector)
                            return creatableObjCObject
                        }

                        bindings.bind(type: InjectCreatableObjCClass.self) { (injector: Injecting) -> AnyObject? in
                            let injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
                            return injectCreatableObjCObject
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

                    it("should have creatable object injected") {
                        expect(objectWithDependencies.creatableObject).notTo(beNil())
                    }

                    it("should inject dependencies in creatable object") {
                        expect(objectWithDependencies.creatableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have creatable ObjC object injected") {
                        expect(objectWithDependencies.creatableObjCObject).to(beAKindOf(CreatableObjCClass.self))
                    }

                    it("should inject dependencies in creatable ObjC object") {
                        expect(objectWithDependencies.creatableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(objectWithDependencies.injectCreatableObjCObject).to(beAKindOf(InjectCreatableObjCClass.self))
                    }

                    it("should have ObjC object injected") {
                        expect(objectWithDependencies.objCObject).to(beAKindOf(ObjCClass.self))
                    }

                }

            }

        }

        describe("automatically injecting dependencies in objects with the injector") {

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

                it("should have creatable object injected") {
                    expect(automaticallyInjectableObject.creatableObject).notTo(beNil())
                }

                it("should inject dependencies in creatable object") {
                    expect(automaticallyInjectableObject.creatableObject!.injectDependenciesCalled).to(beTrue())
                }

                it("should have creatable ObjC object injected") {
                    expect(automaticallyInjectableObject.creatableObjCObject).to(beAKindOf(CreatableObjCClass.self))
                }

                it("should inject dependencies in creatable ObjC object") {
                    expect(automaticallyInjectableObject.creatableObjCObject!.injectDependenciesCalled).to(beTrue())
                }

                it("should have inject-creatable ObjC object injected") {
                    expect(automaticallyInjectableObject.injectCreatableObjCObject).to(beAKindOf(InjectCreatableObjCClass.self))
                }

                it("should have ObjC object injected") {
                    expect(automaticallyInjectableObject.objCObject).to(beAKindOf(ObjCClass.self))
                }

            }

            context("with bindings") {

                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var creatableObject: CreatableClass?
                var creatableObjCObject: CreatableObjCClass?
                var injectCreatableObjCObject: InjectCreatableObjCClass?
                var objCObject: ObjCClass?

                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    creatableObject = CreatableClass()
                    creatableObjCObject = CreatableObjCClass()
                    injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
                    objCObject = ObjCClass()
                }

                context("object bindings") {

                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: creatableObject!, toType: CreatableClass.self)
                        bindings.bind(object: creatableObjCObject!, toType: CreatableObjCClass.self)
                        bindings.bind(object: injectCreatableObjCObject!, toType: InjectCreatableObjCClass.self)
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

                    it("should have creatable object injected") {
                        expect(automaticallyInjectableObject.creatableObject).to(beIdenticalTo(creatableObject))
                    }

                    it("should inject dependencies in creatable object") {
                        expect(automaticallyInjectableObject.creatableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have creatable ObjC object injected") {
                        expect(automaticallyInjectableObject.creatableObjCObject).to(beIdenticalTo(creatableObjCObject))
                    }

                    it("should inject dependencies in creatable ObjC object") {
                        expect(automaticallyInjectableObject.creatableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(automaticallyInjectableObject.injectCreatableObjCObject).to(beIdenticalTo(injectCreatableObjCObject))
                    }

                    it("should have ObjC object injected") {
                        expect(automaticallyInjectableObject.objCObject).to(beIdenticalTo(objCObject))
                    }

                }

                context("closure bindings") {

                    beforeEach {
                        creatableObject?.injectDependencies(injector: injector)
                        creatableObjCObject?.injectDependencies(injector: injector)

                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return objectConformingToProtocol!
                        }

                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return emptySwiftObject!
                        }

                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            return creatableObject!
                        }

                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return creatableObjCObject!
                        }

                        bindings.bind(type: InjectCreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return injectCreatableObjCObject!
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

                    it("should have creatable object injected") {
                        expect(automaticallyInjectableObject.creatableObject).to(beIdenticalTo(creatableObject))
                    }

                    it("should inject dependencies in creatable object") {
                        expect(automaticallyInjectableObject.creatableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have creatable ObjC object injected") {
                        expect(automaticallyInjectableObject.creatableObjCObject).to(beIdenticalTo(creatableObjCObject))
                    }

                    it("should inject dependencies in creatable ObjC object") {
                        expect(automaticallyInjectableObject.creatableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(automaticallyInjectableObject.injectCreatableObjCObject).to(beIdenticalTo(injectCreatableObjCObject))
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
                            let creatableObject = CreatableClass()
                            creatableObject.injectDependencies(injector: injector)
                            return creatableObject
                        }

                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let creatableObjCObject = CreatableObjCClass()
                            creatableObjCObject.injectDependencies(injector: injector)
                            return creatableObjCObject
                        }

                        bindings.bind(type: InjectCreatableObjCClass.self) { (injector: Injecting) -> AnyObject? in
                            let injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
                            return injectCreatableObjCObject
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

                    it("should have creatable object injected") {
                        expect(automaticallyInjectableObject.creatableObject).notTo(beNil())
                    }

                    it("should inject dependencies in creatable object") {
                        expect(automaticallyInjectableObject.creatableObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have creatable ObjC object injected") {
                        expect(automaticallyInjectableObject.creatableObjCObject).to(beAKindOf(CreatableObjCClass.self))
                    }

                    it("should inject dependencies in creatable ObjC object") {
                        expect(automaticallyInjectableObject.creatableObjCObject!.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(automaticallyInjectableObject.injectCreatableObjCObject).to(beAKindOf(InjectCreatableObjCClass.self))
                    }

                    it("should have ObjC object injected") {
                        expect(automaticallyInjectableObject.objCObject).to(beAKindOf(ObjCClass.self))
                    }

                }

            }

        }

        describe("injecting dependencies in objects during initialization with the injector") {

            var injectCreatableObject: InjectCreatableClass!

            context("without any bindings") {

                it("should throw an exception") {
                    expect { injectCreatableObject = InjectCreatableClass(injector: injector) }.to(throwAssertion())
                }

            }

            context("with bindings") {

                var objectConformingToProtocol: ClassConformingToProtocol?
                var emptySwiftObject: EmptySwiftClass?
                var creatableObject: CreatableClass?
                var creatableObjCObject: CreatableObjCClass?
                var injectCreatableObjCObject: InjectCreatableObjCClass?
                var objCObject: ObjCClass?

                beforeEach {
                    objectConformingToProtocol = ClassConformingToProtocol()
                    emptySwiftObject = EmptySwiftClass()
                    creatableObject = CreatableClass()
                    creatableObjCObject = CreatableObjCClass()
                    injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
                    objCObject = ObjCClass()
                }

                context("object bindings") {

                    beforeEach {
                        bindings.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        bindings.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        bindings.bind(object: creatableObject!, toType: CreatableClass.self)
                        bindings.bind(object: creatableObjCObject!, toType: CreatableObjCClass.self)
                        bindings.bind(object: injectCreatableObjCObject!, toType: InjectCreatableObjCClass.self)
                        bindings.bind(object: objCObject!, toType: ObjCClass.self)

                        injectCreatableObject = InjectCreatableClass(injector: injector)
                    }

                    it("should not have object conforming to protocol injected") {
                        expect(injectCreatableObject.objectConformingToProtocol).to(beIdenticalTo(objectConformingToProtocol))
                    }

                    it("should not have empty swift object injected") {
                        expect(injectCreatableObject.emptySwiftObject).to(beIdenticalTo(emptySwiftObject))
                    }

                    it("should have creatable object injected") {
                        expect(injectCreatableObject.creatableObject).to(beIdenticalTo(creatableObject))
                    }

                    it("should inject dependencies in creatable object") {
                        expect(injectCreatableObject.creatableObject.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have creatable ObjC object injected") {
                        expect(injectCreatableObject.creatableObjCObject).to(beIdenticalTo(creatableObjCObject))
                    }

                    it("should inject dependencies in creatable ObjC object") {
                        expect(injectCreatableObject.creatableObjCObject.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(injectCreatableObject.injectCreatableObjCObject).to(beIdenticalTo(injectCreatableObjCObject))
                    }

                    it("should have ObjC object injected") {
                        expect(injectCreatableObject.objCObject).to(beIdenticalTo(objCObject))
                    }

                }

                context("closure bindings") {

                    beforeEach {
                        creatableObject?.injectDependencies(injector: injector)
                        creatableObjCObject?.injectDependencies(injector: injector)

                        bindings.bind(type: EmptySwiftProtocol.self) { (injector: Injecting) -> AnyObject in
                            return objectConformingToProtocol!
                        }

                        bindings.bind(type: EmptySwiftClass.self) { (injector: Injecting) -> AnyObject in
                            return emptySwiftObject!
                        }

                        bindings.bind(type: CreatableClass.self) { (injector: Injecting) -> AnyObject in
                            return creatableObject!
                        }

                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return creatableObjCObject!
                        }

                        bindings.bind(type: InjectCreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return injectCreatableObjCObject!
                        }

                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return objCObject!
                        }

                        injectCreatableObject = InjectCreatableClass(injector: injector)
                    }

                    it("should not have object conforming to protocol injected") {
                        expect(injectCreatableObject.objectConformingToProtocol).to(beIdenticalTo(objectConformingToProtocol))
                    }

                    it("should not have empty swift object injected") {
                        expect(injectCreatableObject.emptySwiftObject).to(beIdenticalTo(emptySwiftObject))
                    }

                    it("should have creatable object injected") {
                        expect(injectCreatableObject.creatableObject).to(beIdenticalTo(creatableObject))
                    }

                    it("should inject dependencies in creatable object") {
                        expect(injectCreatableObject.creatableObject.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have creatable ObjC object injected") {
                        expect(injectCreatableObject.creatableObjCObject).to(beIdenticalTo(creatableObjCObject))
                    }

                    it("should inject dependencies in creatable ObjC object") {
                        expect(injectCreatableObject.creatableObjCObject.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(injectCreatableObject.injectCreatableObjCObject).to(beIdenticalTo(injectCreatableObjCObject))
                    }

                    it("should have ObjC object injected") {
                        expect(injectCreatableObject.objCObject).to(beIdenticalTo(objCObject))
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
                            let creatableObject = CreatableClass()
                            creatableObject.injectDependencies(injector: injector)
                            return creatableObject
                        }

                        bindings.bind(type: CreatableObjCClass.self) { (injector: Injecting) -> AnyObject in
                            let creatableObjCObject = CreatableObjCClass()
                            creatableObjCObject.injectDependencies(injector: injector)
                            return creatableObjCObject
                        }

                        bindings.bind(type: InjectCreatableObjCClass.self) { (injector: Injecting) -> AnyObject? in
                            let injectCreatableObjCObject = InjectCreatableObjCClass(injector: injector)
                            return injectCreatableObjCObject
                        }

                        bindings.bind(type: ObjCClass.self) { (injector: Injecting) -> AnyObject in
                            return ObjCClass()
                        }

                        injectCreatableObject = InjectCreatableClass(injector: injector)
                    }

                    it("should not have object conforming to protocol injected") {
                        expect(injectCreatableObject.objectConformingToProtocol).notTo(beNil())
                    }

                    it("should not have empty swift object injected") {
                        expect(injectCreatableObject.emptySwiftObject).notTo(beNil())
                    }

                    it("should have creatable object injected") {
                        expect(injectCreatableObject.creatableObject).notTo(beNil())
                    }

                    it("should inject dependencies in creatable object") {
                        expect(injectCreatableObject.creatableObject.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have creatable ObjC object injected") {
                        expect(injectCreatableObject.creatableObjCObject).to(beAKindOf(CreatableObjCClass.self))
                    }

                    it("should inject dependencies in creatable ObjC object") {
                        expect(injectCreatableObject.creatableObjCObject.injectDependenciesCalled).to(beTrue())
                    }

                    it("should have inject-creatable ObjC object injected") {
                        expect(injectCreatableObject.injectCreatableObjCObject).to(beAKindOf(InjectCreatableObjCClass.self))
                    }

                    it("should have ObjC object injected") {
                        expect(injectCreatableObject.objCObject).to(beAKindOf(ObjCClass.self))
                    }

                }

            }

        }

    }

}
