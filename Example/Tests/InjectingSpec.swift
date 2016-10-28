// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import Swifjection

class InjectingSpec: QuickSpec {

    override func spec() {

        var injector: SpecInjector!

        beforeEach {
            injector = SpecInjector()
        }

        describe("injectDependencies") {

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
                        injector.bind(object: objectConformingToProtocol!, toType: EmptySwiftProtocol.self)
                        injector.bind(object: emptySwiftObject!, toType: EmptySwiftClass.self)
                        injector.bind(object: injectableObject!, toType: InjectableClass.self)
                        injector.bind(object: injectableObjCObject!, toType: InjectableObjCClass.self)
                        injector.bind(object: objCObject!, toType: ObjCClass.self)

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

                        injector.bind(closure: { (injector: Injecting) -> AnyObject in
                            return objectConformingToProtocol!
                        }, toType: EmptySwiftProtocol.self)

                        injector.bind(closure: { (injector: Injecting) -> AnyObject in
                            return emptySwiftObject!
                        }, toType: EmptySwiftClass.self)

                        injector.bind(closure: { (injector: Injecting) -> AnyObject in
                            return injectableObject!
                        }, toType: InjectableClass.self)

                        injector.bind(closure: { (injector: Injecting) -> AnyObject in
                            return injectableObjCObject!
                        }, toType: InjectableObjCClass.self)

                        injector.bind(closure: { (injector: Injecting) -> AnyObject in
                            return objCObject!
                        }, toType: ObjCClass.self)

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
                        injector.bind(closure: { (injector: Injecting) -> AnyObject in
                            return ClassConformingToProtocol()
                        }, toType: EmptySwiftProtocol.self)

                        injector.bind(closure: { (injector: Injecting) -> AnyObject in
                            return EmptySwiftClass()
                        }, toType: EmptySwiftClass.self)

                        injector.bind(closure: { (injector: Injecting) -> AnyObject in
                            let injectableObject = InjectableClass()
                            injectableObject.injectDependencies(injector: injector)
                            return injectableObject
                        }, toType: InjectableClass.self)

                        injector.bind(closure: { (injector: Injecting) -> AnyObject in
                            let injectableObjCObject = InjectableObjCClass()
                            injectableObjCObject.injectDependencies(injector: injector)
                            return injectableObjCObject
                        }, toType: InjectableObjCClass.self)

                        injector.bind(closure: { (injector: Injecting) -> AnyObject in
                            return ObjCClass()
                        }, toType: ObjCClass.self)

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
