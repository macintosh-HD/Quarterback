//
//  OperationQueue.swift
//  Quarterback
//
//  Created by Julian Gentges on 21.06.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//

import Foundation

public class OperationQueue: Foundation.OperationQueue {
    
    public override func cancelAllOperations() {
        operations.forEach { operation in
            if let asyncOperation = operation as? AnyAsyncResultOperation {
                asyncOperation.cancel(with: Operation.OperationError.cancelled)
            } else {
                operation.cancel()
            }
        }
    }
    
}
