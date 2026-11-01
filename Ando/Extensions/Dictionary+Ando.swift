import Foundation

extension Dictionary {
    init(_ slice: Slice<Dictionary>) {
        self.init(uniqueKeysWithValues: slice.map { ($0.key, $0.value) })
    }
}
