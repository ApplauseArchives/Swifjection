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

/// Helper factory for creating injector, its main purpose is to NOT create default injector when application is being tested.

public class SwifjectorFactory {
    /**
     Returns `Swifjector` instance, when called while not running tests. In tests, it will be set to nil.
     */
    public private(set) var injector: Injecting?
    
    private var runningSpecs: Bool {
        get { return NSClassFromString("XCTest") != nil }
    }
    
    /**
     Initializes `SwifjectorFactory` object, using provided `bindings`, which contains information about instances, closures bound to types, or types bound in singleton scope.
     
     The `SwifjectorFactory` creates `Swifjector` instance only when not running specs. In specs, the `injector` property will contain nil.
     
     - Parameter bindings: Object containing information about instances, closures bound to types, or types bound in singleton scope. This `bindings` object will be passed to `Swifjector` initializer.
     
     - Returns: An initialized `SwifjectorFactory` object.
     */
    public init(bindings: Bindings) {
        if runningSpecs == false {
            self.injector = Swifjector(bindings: bindings)
        }
    }
}
