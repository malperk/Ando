import Foundation
#if canImport(UIKit)
import UIKit
#endif

protocol ItemType {
    func get(_ data: Data) throws -> Any
}

struct Item {
    private let processor: any ItemType

    init(type: AType) {
        switch type {
        case .image: processor = ImageItem()
        case .json: processor = JSONItem()
        }
    }

    func get(_ data: Data) throws -> Any {
        try processor.get(data)
    }
}

private struct ImageItem: ItemType {
    func get(_ data: Data) throws -> Any {
        #if canImport(UIKit)
        if let image = UIImage(data: data) { return image }
        #endif
        throw AError.error(code: .ItemCreatingError, failureReason: "Unable to decode an image")
    }
}

private struct JSONItem: ItemType {
    func get(_ data: Data) throws -> Any {
        try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
    }
}
