//
//  Copyright © 2016 Applause Inc. All rights reserved.
//

public protocol Binding {
    func getObject(withInjector injector: Injecting) -> Any
}
