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

/// Describes a type which can have its dependencies injected automatically

public protocol AutoInjectable: class, Injectable {
    /**
     Array of objects conforming to `InjectableProperty` protocol, used to inject automatically.
     */
    var injectableProperties: [InjectableProperty] { get }

    /**
     Automatically injects inner dependencies using provided `injector` object.

     When implementing an object conforming to `AutoInjectable` protocol, default implementation of this function is called from default implementation of `injectDependencies(injector:)` and automatically creates dependant objects and sets them to the properties.

     The `injector` object can be used to inject inner dependencies of `AutoInjectable` object.

     - Parameter injector: An object used to inject inner dependencies.
     */
    func autoinjectDependencies(injector: Injecting)
}

public extension AutoInjectable {
    
    func autoinjectDependencies(injector: Injecting) {
        for injectableProperty in injectableProperties {
            injectableProperty.inject(to: self, with: injector)
        }
    }

}
