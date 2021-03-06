//
//  ChainedOperationOutputProviding.swift
//  Quarterback
//
//  Created by Julian Gentges on 23.03.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//

import Foundation

public protocol ChainedOperationOutputProviding where Self: Operation {
    var output: Any? { get }
}
