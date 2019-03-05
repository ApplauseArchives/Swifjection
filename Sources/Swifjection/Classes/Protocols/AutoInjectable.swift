//
//  AutoInjectable.swift
//  Swifjection
//
//  Created by Łukasz Przytuła on 04/03/2019.
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import Foundation

public protocol AutoInjectable: class, Injectable {

    var injectableProperties: [InjectableProperty] { get }
    func autoinjectDependencies(injector: Injecting)
    
}

public extension AutoInjectable {

    func autoinjectDependencies(injector: Injecting) {
        for injectableProperty in injectableProperties {
            injectableProperty.inject(to: self, with: injector)
        }
    }

}
