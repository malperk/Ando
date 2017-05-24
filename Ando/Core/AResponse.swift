//
//  AResponse.swift
//  Pods
//
//  Created by Alper KARATAŞ on 23/05/2017.
//
//

import Foundation

public struct AResponse {
    public let item: Any?
    public let type: AType
    public let error: NSError?
    
    init(item: Any?, type: AType, error: NSError?) {
        self.item = item
        self.type = type
        self.error = error
    }
    
    init(error: NSError, type: AType) {
        self.item = nil
        self.type = type
        self.error = error
    }
    
    init(item: Any, type: AType) {
        self.item = item
        self.type = type
        self.error = nil
    }
}
