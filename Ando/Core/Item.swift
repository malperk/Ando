//
//  Item.swift
//  Ando
//
//  Created by Alper KARATAŞ on 23/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

protocol ItemType {
    func get(_ data: Data) throws -> Any
}

final class Item {
    private let type: ItemType
    
    func get(_ data: Data) throws -> Any{
        return try self.type.get(data)
    }
    
    init(type: AType) {
        switch type {
        case .image:
            self.type = Image()
        case .json:
            self.type = Json()
        }
    }
}

final class Image: ItemType {
    internal func get(_ data: Data) throws -> Any {
        if let image = UIImage(data: data){
            return image
        }
        throw AError.error(code: .ItemCreatingError, failureReason: "Cannot create an image from url")
    }
}

final class Json: ItemType {
    internal func get(_ data: Data) throws -> Any {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return json
        } catch let error {
            throw error
        }
    }
}
