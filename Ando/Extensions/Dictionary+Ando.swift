//
//  Dictionary+Ando.swift
//  Ando
//
//  Created by Alper KARATAŞ on 23/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

extension Dictionary {
    
    init(_ slice: Slice<Dictionary>) {
        self = [:]
        
        for (key, value) in slice {
            self[key] = value
        }
    }
    
}
