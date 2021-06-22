//
//  ObservableOperation.swift
//  Quarterback
//
//  Created by Julian Gentges on 22.06.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//

import Foundation

open class ObservableOperation: AsyncOperation {
    
    public private(set) var observers = [OperationObserver]()
    private var hasFinishedAlready = false
    
    public func addObserver(observer: OperationObserver) {
        assert(!isExecuting, "Cannot modify observers after execution has begun.")
        
        observers.append(observer)
    }
    
    open override func main() {
        assert(isReady, "This operation must be performed on an operation queue.")
        
        observers.forEach { observer in
            observer.operationDidStart(self)
        }
    }
    
    open override func cancel() {
        observers.forEach { observer in
            observer.operationWasCancelled(self)
        }
    }
    
    public override func finish() {
        if !hasFinishedAlready {
            observers.forEach { observer in
                observer.operationDidFinish(self, withErrors: [])
            }
        }
        
        super.finish()
    }
    
}
