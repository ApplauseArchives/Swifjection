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

/// Binds given type to lazy singleton object -- instance will be created when type is requested

import Foundation

public class SingletonBinding: Binding {
    /**
     Returns the `type` provided during initialization of binding.
     */
    var type: Any.Type
    
    /**
     An instance of provided `type`, created during first call of the `getObject(withInjector injector: Injecting) -> Any?` function.
     */
    var instance: Any?
    
    /**
     Initializes `SingletonBinding` object, using provided `type`.
     
     - Parameter type: An Type which should be bound in singleton scope.
     
     - Returns: An initialized `SingletonBinding` object.
     */
    public init(withType type: Any.Type) {
        self.type = type
    }
    
    /**
     Creates and keeps an instance of provided `type`.
     
     During first call, a new instance of `type` is created using the `injector`, and assigned to the `instance` property.
     Each subsequent call uses the object assigned to `instance` property.
     
     - Parameter injector: An `injector` used to create new instance, during first call to the function.
     
     - Returns: An singleton instance of `type` provided during initialization of this binding.
     */
    public func getObject(withInjector injector: Injecting) -> Any? {
        if self.instance == nil {
            if let type = self.type as? Injectable.Type {
                let instance = type.init(injector: injector)
                instance?.injectDependencies(injector: injector)
                self.instance = instance
            } else if let type = self.type as? NSObject.Type {
                self.instance = type.init()
            }
        }
        return self.instance!
    }
}
