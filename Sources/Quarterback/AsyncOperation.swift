//
//  AsyncOperation.swift
//  Quarterback
//
//  Created by Julian Gentges on 03.03.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//
//  Based on code from: https://www.avanderlee.com/swift/asynchronous-operations/
//

import Foundation

open class AsyncOperation: Operation {
    
    private let lockQueue = DispatchQueue(label: "com.resonance.asyncoperation", attributes: .concurrent)
    
    open override var isAsynchronous: Bool { true }
    
    private var _isExecuting = false
    public override private(set) var isExecuting: Bool {
        get {
            lockQueue.sync { _isExecuting }
        }
        set {
            willChangeValue(forKey: #keyPath(isExecuting))
            lockQueue.sync(flags: .barrier) { _isExecuting = newValue }
            didChangeValue(forKey: #keyPath(isExecuting))
        }
    }
    
    private var _isFinished = false
    public override private(set) var isFinished: Bool {
        get {
            lockQueue.sync { _isFinished }
        }
        set {
            willChangeValue(forKey: #keyPath(isFinished))
            lockQueue.sync(flags: .barrier) { _isFinished = newValue }
            didChangeValue(forKey: #keyPath(isFinished))
        }
    }
    
    public override func start() {
        guard !isCancelled else {
            finish()
            return
        }
        
        isFinished = false
        isExecuting = true
        main()
    }
    
    open override func main() {
        fatalError("Subclasses must implement `main` without overriding `super`.")
    }
    
    public func finish() {
        isExecuting = false
        isFinished = true
    }
}
