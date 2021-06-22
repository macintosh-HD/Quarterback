//
//  TestOperation.swift
//  Quarterback
//
//  Created by Julian Gentges on 04.04.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//

import Foundation

final class TestOperation: Operation {
    
    override func cancel() {
        print("\(String(describing: self)) got cancelled.")
    }
    
    override func main() {
        guard dependencies.allSatisfy({ !$0.isCancelled }), !isCancelled else {
            return
        }
        
        print("\(String(describing: self)) was executed.")
    }
    
}
