//
//  InjectableKeyPath.swift
//  Swifjection
//
//  Created by Łukasz Przytuła on 05/03/2019.
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import Foundation

struct InjectableKeyPath<R>: InjectableProperty {

    private let injectClosure: (R, Injecting) -> Void

    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) where T: Any {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) where T: NSObject {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) where T: Injectable {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) where T: NSObject, T: Injectable {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, T>) where T: Any {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, T>) where T: NSObject {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, T>) where T: Injectable {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    public init<T>(_ keyPath: ReferenceWritableKeyPath<R, T>) where T: NSObject, T: Injectable {
        injectClosure = { instance, injector in
            if let value: T = injector.getObject(withType: T.self) {
                instance[keyPath: keyPath] = value
            }
        }
    }

    public func inject<T: AnyObject>(to owner: T, with injector: Injecting) {
        guard let castedOwner = owner as? R else {
            return
        }
        injectClosure(castedOwner, injector)
    }

}

public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) -> InjectableProperty where T: Any {
    return InjectableKeyPath(keyPath)
}

public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) -> InjectableProperty where T: NSObject {
    return InjectableKeyPath(keyPath)
}

public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) -> InjectableProperty where T: Injectable {
    return InjectableKeyPath(keyPath)
}

public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, Optional<T>>) -> InjectableProperty where T: NSObject & Injectable {
    return InjectableKeyPath(keyPath)
}

public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, T>) -> InjectableProperty where T: Any {
    return InjectableKeyPath(keyPath)
}

public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, T>) -> InjectableProperty where T: NSObject {
    return InjectableKeyPath(keyPath)
}

public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, T>) -> InjectableProperty where T: Injectable {
    return InjectableKeyPath(keyPath)
}

public func requires<R, T>(_ keyPath: ReferenceWritableKeyPath<R, T>) -> InjectableProperty where T: NSObject & Injectable {
    return InjectableKeyPath(keyPath)
}
