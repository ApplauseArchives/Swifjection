//
//  Copyright © 2019 Applause Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public extension Injecting {

    public func getObject<T>(withType type: T.Type) -> T? where T: Any {
        guard let object = bindings[type]?.getObject(withInjector: self) as? T else {
            return nil
        }
        if let injectable = object as? Injectable {
            injectable.injectDependencies(injector: self)
        }
        return object
    }

    public func getObject<T>(withType type: T.Type) -> T? where T: NSObject {
        let object: T
        if let objectFromBinding = bindings[type]?.getObject(withInjector: self) as? T {
            object = objectFromBinding
        } else {
            object = type.init()
        }
        if let injectable = object as? Injectable {
            injectable.injectDependencies(injector: self)
        }
        return object
    }

    public func getObject<T>(withType type: T.Type) -> T? where T: Creatable {
        let object: T
        if let objectFromBinding = bindings[type]?.getObject(withInjector: self) as? T {
            object = objectFromBinding
        } else {
            object = type.init()
        }
        if let injectable = object as? Injectable {
            injectable.injectDependencies(injector: self)
        }
        return object
    }

    public func getObject<T>(withType type: T.Type) -> T? where T: NSObject, T: Creatable {
        let object: T
        if let objectFromBinding = bindings[type]?.getObject(withInjector: self) as? T {
            object = objectFromBinding
        } else if let createdObject = (type as Creatable.Type).init() as? T {
            object = createdObject
        } else {
            return nil
        }
        if let injectable = object as? Injectable {
            injectable.injectDependencies(injector: self)
        }
        return object
    }

    public subscript(type: Any.Type) -> Any? {
        guard let object = bindings[type]?.getObject(withInjector: self) else {
            return nil
        }
        if let injectable = object as? Injectable {
            injectable.injectDependencies(injector: self)
        }
        return object
    }

    public subscript(type: NSObject.Type) -> NSObject? {
        let object: NSObject
        if let objectFromBinding = bindings[type]?.getObject(withInjector: self) as? NSObject {
            object = objectFromBinding
        } else {
            object = type.init()
        }
        if let injectable = object as? Injectable {
            injectable.injectDependencies(injector: self)
        }
        return object
    }

    public subscript(type: Creatable.Type) -> Creatable? {
        let object: Creatable
        if let objectFromBinding = bindings[type]?.getObject(withInjector: self) as? Creatable {
            object = objectFromBinding
        } else {
            object = type.init()
        }
        if let injectable = object as? Injectable {
            injectable.injectDependencies(injector: self)
        }
        return object
    }

}
