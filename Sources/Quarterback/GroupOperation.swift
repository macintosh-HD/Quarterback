//
//  GroupOperation.swift
//  Quarterback
//
//  Created by Julian Gentges on 07.03.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//

import Foundation

public protocol OperationObserver {
    func operationDidStart(_ operation: Operation)
    func operationWasCancelled(_ operation: Operation)
    func operationDidFinish(_ operation: Operation, withErrors errors: [Error])
}

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

open class GroupOperation: ObservableOperation {
    
    public let internalQueue = OperationQueue()
    public private(set) var lastOperation: Operation
    
    private var aggregatedErrors = [Error]()
    
    public convenience init(operations: Operation...) {
        self.init(operations: operations)
    }
    
    public init(operations: [Operation]) {
        assert(!operations.isEmpty, "Cannot initialize GroupOperation with an empty Array.")
        lastOperation = operations.last!
        
        super.init()
        
        lastOperation.completionBlock = {
            self.lastOperation.completionBlock?()
            self.finish()
        }

        internalQueue.isSuspended = true
//        operations.forEach { internalQueue.addOperation($0) }
        internalQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    open override func cancel() {
        internalQueue.cancelAllOperations()
        internalQueue.isSuspended = false
        
        super.cancel()
    }
    
    open override func main() {
        print("Group Task: \(String(describing: self)) will start")
        internalQueue.isSuspended = false
        
        super.main()
    }
    
}

extension OperationObserver {
    func operationDidStart(_ operation: Operation) {}
    func operationWasCancelled(_ operation: Operation) {}
    func operationDidFinish(_ operation: Operation, withErrors errors: [Error]) {}
}
