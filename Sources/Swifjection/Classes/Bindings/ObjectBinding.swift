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

/// Binds concrete instance of the object to given type.

public class ObjectBinding: Binding {
    /**
     Returns the `object` provided during initialization of binding.
     */
    var object: Any?
    
    /**
     Initializes `ClosureBinding` object, using provided `object`.
     
     - Parameter object: An object of `Any` type, returned by `getObject` function.
     
     - Returns: An initialized `ObjectBinding` object.
     */
    public init(withObject object: Any?) {
        self.object = object
    }
    
    /**
     - Parameter injector: The injector is not used in this binding.
     
     - Returns: Object provided during initialization of binding.
     */
    public func getObject(withInjector injector: Injecting) -> Any? {
        return object
    }
}
