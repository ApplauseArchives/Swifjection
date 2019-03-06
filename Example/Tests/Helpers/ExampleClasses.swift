//
//  Copyright © 2017 Applause Inc. All rights reserved.
//

import Foundation
@testable import Swifjection

protocol EmptySwiftProtocol {}

class ClassConformingToProtocol: EmptySwiftProtocol {}

struct StructConformingToProtocol: EmptySwiftProtocol {}

class EmptySwiftClass {}

protocol InjectableClassProtocol: class, Creatable, Injectable {}

class InjectableClass: InjectableClassProtocol {
    
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

class InjectableObjCClass: NSObject, Creatable, Injectable {
    
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
    var injectableObject: InjectableClass?
    var injectableObjCObject: InjectableObjCClass?
    var objCObject: ObjCClass?
    
    required init() {}
    
    func injectDependencies(injector: Injecting) {
        self.injector = injector
        self.objectConformingToProtocol = injector.getObject(withType: EmptySwiftProtocol.self)
        self.emptySwiftObject = injector.getObject(withType: EmptySwiftClass.self)
        self.injectableObject = injector.getObject(withType: InjectableClass.self)
        self.injectableObjCObject = injector.getObject(withType: InjectableObjCClass.self)
        self.objCObject = injector.getObject(withType: ObjCClass.self)
    }
    
}

class AutoInjectableClass: Creatable, AutoInjectable {

    var injector: Injecting?

    var objectConformingToProtocol: EmptySwiftProtocol?
    var emptySwiftObject: EmptySwiftClass?
    var injectableObject: InjectableClass?
    var injectableObjCObject: InjectableObjCClass?
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
