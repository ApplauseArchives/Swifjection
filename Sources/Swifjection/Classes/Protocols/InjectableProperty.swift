//
//  InjectableProperty.swift
//  Swifjection
//
//  Created by Łukasz Przytuła on 05/03/2019.
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import Foundation

public protocol InjectableProperty {
    func inject<T: AnyObject>(to owner: T, with injector: Injecting)
}
