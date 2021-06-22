//
//  ChainedStartOperation.swif
//  Quarterback
//
//  Created by Julian Gentges on 23.03.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//

import Foundation

open class ChainedStartOperation<Output>: Operation, ChainedOperationOutputProviding {
    
    private(set) public var output: Any?
    
    public init(startValue output: Output) {
        self.output = output
        
        super.init()
    }
    
    public override func start() {
        super.start()
        debugPrint(self, " was started")
    }
    
    open override func cancel() {
        super.cancel()
        debugPrint(self, " was cancelled.")
    }
    
    open override func main() {
        guard dependencies.allSatisfy({ !$0.isCancelled }), !isCancelled else {
            return
        }
        
        debugPrint(self, " is executing.")
    }
    
}
