//
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import Foundation
@testable import Swifjection

protocol EmptySwiftProtocol {}

class ClassConformingToProtocol: EmptySwiftProtocol {}

struct StructConformingToProtocol: EmptySwiftProtocol {}

class EmptySwiftClass {}

protocol CreatableClassProtocol: class, Creatable, Injectable {}

class CreatableClass: CreatableClassProtocol {
    
    var injector: Injecting?
    
    var injectDependenciesCalled = false
    var initCallsCount = 0
    var injectDependenciesCallsCount = 0
    
    required init() {
        self.initCallsCount += 1
    }
    
    func injectDependencies(injector: Injecting) {
        self.injector = injector
        self.injectDependenciesCalled = true
        self.injectDependenciesCallsCount += 1
    }
    
}

class CreatableObjCClass: NSObject, Creatable, Injectable {
    
    var injector: Injecting?
    
    var injectDependenciesCalled = false
    var initCallsCount = 0
    var injectDependenciesCallsCount = 0
    
    required override init() {
        super.init()
        self.initCallsCount += 1
    }
    
    func injectDependencies(injector: Injecting) {
        self.injector = injector
        self.injectDependenciesCalled = true
        self.injectDependenciesCallsCount += 1
    }
    
}

class ObjCClass: NSObject {
    
    var initCallsCount = 0
    
    override init() {
        self.initCallsCount += 1
    }

}

class ClassWithDependencies: Creatable, Injectable {
    
    var injector: Injecting?
    
    var objectConformingToProtocol: EmptySwiftProtocol?
    var emptySwiftObject: EmptySwiftClass?
    var injectableObject: CreatableClass?
    var injectableObjCObject: CreatableObjCClass?
    var objCObject: ObjCClass?
    
    required init() {}
    
    func injectDependencies(injector: Injecting) {
        self.injector = injector
        self.objectConformingToProtocol = injector.getObject(withType: EmptySwiftProtocol.self)
        self.emptySwiftObject = injector.getObject(withType: EmptySwiftClass.self)
        self.injectableObject = injector.getObject(withType: CreatableClass.self)
        self.injectableObjCObject = injector.getObject(withType: CreatableObjCClass.self)
        self.objCObject = injector.getObject(withType: ObjCClass.self)
    }
    
}

class AutoInjectableClass: Creatable, AutoInjectable {

    var injector: Injecting?

    var objectConformingToProtocol: EmptySwiftProtocol?
    var emptySwiftObject: EmptySwiftClass?
    var injectableObject: CreatableClass?
    var injectableObjCObject: CreatableObjCClass?
    var objCObject: ObjCClass?

    var injectableProperties: [InjectableProperty] {
        return [
            requires(\AutoInjectableClass.objectConformingToProtocol),
            requires(\AutoInjectableClass.emptySwiftObject),
            requires(\AutoInjectableClass.injectableObject),
            requires(\AutoInjectableClass.injectableObjCObject),
            requires(\AutoInjectableClass.objCObject),
        ]
    }

    required init() {}

    func injectDependencies(injector: Injecting) {
        self.injector = injector
        autoinjectDependencies(injector: injector)
    }

}

class InjectCreatableClass: InjectCreatable {

    var injector: Injecting

    var objectConformingToProtocol: EmptySwiftProtocol
    var emptySwiftObject: EmptySwiftClass
    var injectableObject: CreatableClass
    var injectableObjCObject: CreatableObjCClass
    var objCObject: ObjCClass

    required init?(injector: Injecting) {
        guard let objectConformingToProtocol = injector.getObject(withType: EmptySwiftProtocol.self),
              let emptySwiftObject = injector.getObject(withType: EmptySwiftClass.self),
              let injectableObject = injector.getObject(withType: CreatableClass.self),
              let injectableObjCObject = injector.getObject(withType: CreatableObjCClass.self),
              let objCObject = injector.getObject(withType: ObjCClass.self) else {
            assertionFailure("Could not initialize all stored properties")
            return nil
        }
        self.injector = injector
        self.objectConformingToProtocol = objectConformingToProtocol
        self.emptySwiftObject = emptySwiftObject
        self.injectableObject = injectableObject
        self.injectableObjCObject = injectableObjCObject
        self.objCObject = objCObject
    }

}
