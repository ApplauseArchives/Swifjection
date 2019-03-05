//
//  AutoInjectableObject.swift
//  Example
//
//  Created by Łukasz Przytuła on 04/03/2019.
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import Foundation
import Swifjection

class AutoInjectableObject: AutoInjectable {
    
    var foo: Foo?
    var fie: Fie?
    var fie2: Fie?
    var singleton: ExampleSingleton?
    var object: MyObject?

    var injectableProperties: [InjectableProperty] {
        return [
            requires(\AutoInjectableObject.foo),
            requires(\AutoInjectableObject.fie),
            requires(\AutoInjectableObject.fie2),
            requires(\AutoInjectableObject.singleton),
            requires(\AutoInjectableObject.object)
        ]
    }

    required init?(injector: Injecting) {}


}
