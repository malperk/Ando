#if canImport(UIKit)
import UIKit
import ObjectiveC

// The associated object is only accessed on the main actor.
nonisolated(unsafe) private var andoAssociationKey: UInt8 = 0

@MainActor
public extension UIImageView {
    var ando: Ando {
        if let existing = objc_getAssociatedObject(self, &andoAssociationKey) as? Ando {
            return existing
        }
        let downloader = Ando()
        downloader.callback = { [weak self] response in
            guard let image = response.item as? UIImage, response.error == nil else { return }
            self?.image = image
        }
        objc_setAssociatedObject(self, &andoAssociationKey, downloader, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return downloader
    }
}
#endif
