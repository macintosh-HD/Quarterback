//
//  Operation+Error.swift
//  Quarterback
//
//  Created by Julian Gentges on 02.03.21.
//  Copyright © 2021 Julian Gentges. All rights reserved.
//

import Foundation

public extension Operation {
    enum OperationError: AsyncResultError {
        case cancelled
    }
}
