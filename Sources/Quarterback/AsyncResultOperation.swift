//
//  AsyncResultOperation.swift
//  Quarterback
//
//  Created by Julian Gentges on 03.03.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//
//  Based on code from: https://www.avanderlee.com/swift/advanced-asynchronous-operations/
//

import Foundation

protocol AnyAsyncResultOperation: AsyncOperation {
    func cancel(with error: AsyncResultError)
}

public protocol AsyncResultError: Error {}

open class AsyncResultOperation<Success, Failure>: AsyncOperation where Failure: AsyncResultError {
    
    public private(set) var result: Result<Success, Failure>?
    
    final override public func finish() {
        guard !isCancelled else {
            return super.finish()
        }
        
        fatalError("Make use of finish(with:) instaed to ensure a result.")
    }
    
    public func finish(with result: Result<Success, Failure>) {
        self.result = result
        
        debugPrint(self, " finished")
        
        super.finish()
    }
    
    override open func cancel() {
        fatalError("Make use of cancel(with:) instead to ensure a result.")
    }
    
    public func cancel(with error: Failure) {
        self.result = .failure(error)
        
        super.cancel()
    }
    
}
