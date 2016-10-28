//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation
@testable import Swifjection

protocol EmptySwiftProtocol {}

class ClassConformingToProtocol: EmptySwiftProtocol {}

class EmptySwiftClass {}

class InjectableClass: Injectable {
    
    var injector: Injecting?
    
    var injectDependenciesCalled = false
    
    required convenience init?(injector: Injecting) {
        self.init()
        self.injector = injector
    }
    
    func injectDependencies(injector: Injecting) {
        self.injectDependenciesCalled = true
    }
    
}

class InjectableObjCClass: NSObject, Injectable {
    
    var injector: Injecting?
    
    var injectDependenciesCalled = false
    
    required convenience init?(injector: Injecting) {
        self.init()
        self.injector = injector
    }
    
    func injectDependencies(injector: Injecting) {
        self.injectDependenciesCalled = true
    }
    
}

class ObjCClass: NSObject {}

class ClassWithDependencies: Injectable {
    
    var injector: Injecting?
    
    var objectConformingToProtocol: EmptySwiftProtocol?
    var emptySwiftObject: EmptySwiftClass?
    var injectableObject: InjectableClass?
    var injectableObjCObject: InjectableObjCClass?
    var objCObject: ObjCClass?
    
    required convenience init?(injector: Injecting) {
        self.init()
        self.injector = injector
    }
    
    func injectDependencies(injector: Injecting) {
        self.objectConformingToProtocol = injector.getObject(withType: EmptySwiftProtocol.self)
        self.emptySwiftObject = injector.getObject(withType: EmptySwiftClass.self)
        self.injectableObject = injector.getObject(withType: InjectableClass.self)
        self.injectableObjCObject = injector.getObject(withType: InjectableObjCClass.self)
        self.objCObject = injector.getObject(withType: ObjCClass.self)
    }
    
}
