//
//  OperationObserver.swift
//  Quarterback
//
//  Created by Julian Gentges on 22.06.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//

import Foundation

public protocol OperationObserver {
    func operationDidStart(_ operation: Operation)
    func operationWasCancelled(_ operation: Operation)
    func operationDidFinish(_ operation: Operation, withErrors errors: [Error])
}

public extension OperationObserver {
    func operationDidStart(_ operation: Operation) {}
    func operationWasCancelled(_ operation: Operation) {}
    func operationDidFinish(_ operation: Operation, withErrors errors: [Error]) {}
}
