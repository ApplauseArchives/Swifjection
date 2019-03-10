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

class InjectCreatableObjCClass: NSObject, InjectCreatable {

    var injector: Injecting
    let creatableObject: CreatableClass
    var initWithInjectorCalled = false

    required init?(injector: Injecting) {
        initWithInjectorCalled = true
        self.injector = injector
        guard let creatableObject = injector.getObject(withType: CreatableClass.self) else {
            return nil
        }
        self.creatableObject = creatableObject
        super.init()
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
    var creatableObject: CreatableClass?
    var creatableObjCObject: CreatableObjCClass?
    var injectCreatableObjCObject: InjectCreatableObjCClass?
    var objCObject: ObjCClass?
    
    required init() {}
    
    func injectDependencies(injector: Injecting) {
        self.injector = injector
        self.objectConformingToProtocol = injector.getObject(withType: EmptySwiftProtocol.self)
        self.emptySwiftObject = injector.getObject(withType: EmptySwiftClass.self)
        self.creatableObject = injector.getObject(withType: CreatableClass.self)
        self.creatableObjCObject = injector.getObject(withType: CreatableObjCClass.self)
        self.injectCreatableObjCObject = injector.getObject(withType: InjectCreatableObjCClass.self)
        self.objCObject = injector.getObject(withType: ObjCClass.self)
    }
    
}

class AutoInjectableClass: Creatable, AutoInjectable {

    var injector: Injecting?

    var objectConformingToProtocol: EmptySwiftProtocol?
    var emptySwiftObject: EmptySwiftClass?
    var creatableObject: CreatableClass?
    var creatableObjCObject: CreatableObjCClass?
    var injectCreatableObjCObject: InjectCreatableObjCClass?
    var objCObject: ObjCClass?

    var injectableProperties: [InjectableProperty] {
        return [
            requires(\AutoInjectableClass.objectConformingToProtocol),
            requires(\AutoInjectableClass.emptySwiftObject),
            requires(\AutoInjectableClass.creatableObject),
            requires(\AutoInjectableClass.creatableObjCObject),
            requires(\AutoInjectableClass.injectCreatableObjCObject),
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
    var creatableObject: CreatableClass
    var creatableObjCObject: CreatableObjCClass
    var injectCreatableObjCObject: InjectCreatableObjCClass
    var objCObject: ObjCClass

    required init?(injector: Injecting) {
        guard let objectConformingToProtocol = injector.getObject(withType: EmptySwiftProtocol.self),
              let emptySwiftObject = injector.getObject(withType: EmptySwiftClass.self),
              let creatableObject = injector.getObject(withType: CreatableClass.self),
              let creatableObjCObject = injector.getObject(withType: CreatableObjCClass.self),
              let injectCreatableObjCObject = injector.getObject(withType: InjectCreatableObjCClass.self),
              let objCObject = injector.getObject(withType: ObjCClass.self) else {
            assertionFailure("Could not initialize all stored properties")
            return nil
        }
        self.injector = injector
        self.objectConformingToProtocol = objectConformingToProtocol
        self.emptySwiftObject = emptySwiftObject
        self.creatableObject = creatableObject
        self.creatableObjCObject = creatableObjCObject
        self.creatableObjCObject = creatableObjCObject
        self.injectCreatableObjCObject = injectCreatableObjCObject
        self.objCObject = objCObject
    }

}
