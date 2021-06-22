//
//  ChainedAsyncResultOperation.swift
//  Quarterback
//
//  Created by Julian Gentges on 03.03.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//
//  Based on code from: https://www.avanderlee.com/swift/advanced-asynchronous-operations/
//

import Foundation

open class ChainedAsyncResultOperation<Input, Output, Failure>: AsyncResultOperation<Output, Failure> where Failure: AsyncResultError {
    
    private(set) public var input: Input?
    
    public init(input: Input? = nil) {
        self.input = input
    }
    
    override public final func start() {
        updateInputFromDependencies()
        
        super.start()
    }
    
    private func updateInputFromDependencies() {
        guard input == nil else {
            return
        }
        
        input = dependencies.compactMap { dependency in
            return (dependency as? ChainedOperationOutputProviding)?.output as? Input
        }.first
    }
    
    open override func cancel() {
        cancel(with: .cancelled)
    }
    
}

extension ChainedAsyncResultOperation: ChainedOperationOutputProviding {
    public var output: Any? {
        return try? result?.get()
    }
}
