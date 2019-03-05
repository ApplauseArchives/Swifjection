//
//  Copyright © 2017 Applause Inc. All rights reserved.
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

/// Describes a type which is compatible with Swijection -- it can have its dependencies injected and can be created from injector  

public protocol Injectable {
    /**
     Initializes injectable object, using provided `injector`.
     
     The `injector` object can be used to inject inner dependencies of created `Injectable` object.
     
     - Parameter injector: An object used to inject inner dependencies.
     
     - Returns: An initialized `Injectable` object, or nil.
     */
    init?(injector: Injecting)
    
    /**
     Injects inner dependencies using provided `injector` object.
     
     When implementing an object conforming to `Injectable` protocol, this function is the place where injector should be used to inject inner dependencies of the object.
     
     The `injector` object can be used to inject inner dependencies of created `Injectable` object.
     
     - Parameter injector: An object used to inject inner dependencies.
     */
    func injectDependencies(injector: Injecting)
}

public extension Injectable {
    func injectDependencies(injector: Injecting) {
        guard let autoinjectableSelf = self as? AutoInjectable else {
            return
        }
        autoinjectableSelf.autoinjectDependencies(injector: injector)
    }
}
