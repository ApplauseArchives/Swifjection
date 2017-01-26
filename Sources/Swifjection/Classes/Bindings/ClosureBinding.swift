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

/// Binds closure to create an object for given type. 

public class ClosureBinding: Binding {
    /**
     Returns the `closure` provided during initialization of binding.
     
     Injector will be passed when calling the `closure` and can be used to create returned object.
     */
    var closure: ((Injecting) -> Any)
    
    /**
     Initializes `ClosureBinding` object, using provided `closure`.
     
     - Parameter closure: An closure used by `getObject` function to return some object.
     
     - Returns: An initialized `ClosureBinding` object.
     */
    public init(withClosure closure: @escaping (Injecting) -> Any) {
        self.closure = closure
    }
    
    /**
     Uses the `closure` provided during initialization, to return an object.
     
     - Parameter injector: Injector which can be used in the closure to provide object to return.
     
     - Returns: Object created using the `closure`.
     */
    public func getObject(withInjector injector: Injecting) -> Any? {
        return self.closure(injector)
    }    
}
