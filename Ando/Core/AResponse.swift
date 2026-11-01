import Foundation

/// `item` contains a UIImage for `.image` or a Foundation JSON value for `.json`.
public struct AResponse {
    public let item: Any?
    public let type: AType
    public let error: NSError?

    init(item: Any?, type: AType, error: NSError? = nil) {
        self.item = item
        self.type = type
        self.error = error
    }

    init(error: NSError, type: AType) {
        self.init(item: nil, type: type, error: error)
    }
}
