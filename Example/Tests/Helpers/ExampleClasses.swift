//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

import Foundation
@testable import Swifjection

protocol EmptySwiftProtocol {}

class ClassConformingToProtocol: EmptySwiftProtocol {}

class EmptySwiftClass {}

class InjectableClass: Injectable {
    
    var injector: Swifjector?
    
    var injectDependenciesCalled = false
    var initCallsCount = 0
    var injectDependenciesCallsCount = 0
    
    required convenience init?(injector: Swifjector) {
        self.init()
        self.initCallsCount += 1
        self.injector = injector
    }
    
    func injectDependencies(injector: Swifjector) {
        self.injectDependenciesCalled = true
        self.injectDependenciesCallsCount += 1
    }
    
}

class InjectableObjCClass: NSObject, Injectable {
    
    var injector: Swifjector?
    
    var injectDependenciesCalled = false
    var initCallsCount = 0
    var injectDependenciesCallsCount = 0
    
    required convenience init?(injector: Swifjector) {
        self.init()
        self.initCallsCount += 1
        self.injector = injector
    }
    
    func injectDependencies(injector: Swifjector) {
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

class ClassWithDependencies: Injectable {
    
    var injector: Swifjector?
    
    var objectConformingToProtocol: EmptySwiftProtocol?
    var emptySwiftObject: EmptySwiftClass?
    var injectableObject: InjectableClass?
    var injectableObjCObject: InjectableObjCClass?
    var objCObject: ObjCClass?
    
    required convenience init?(injector: Swifjector) {
        self.init()
        self.injector = injector
    }
    
    func injectDependencies(injector: Swifjector) {
        self.objectConformingToProtocol = injector.getObject(withType: EmptySwiftProtocol.self)
        self.emptySwiftObject = injector.getObject(withType: EmptySwiftClass.self)
        self.injectableObject = injector.getObject(withType: InjectableClass.self)
        self.injectableObjCObject = injector.getObject(withType: InjectableObjCClass.self)
        self.objCObject = injector.getObject(withType: ObjCClass.self)
    }
    
}
