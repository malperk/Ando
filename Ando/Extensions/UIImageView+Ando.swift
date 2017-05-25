//
//  UIImageView+Ando.swift
//  Ando
//
//  Created by Alper KARATAŞ on 24/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

private var aKey: UInt8 = 0

public extension UIImageView {
    var ando: Ando {
        if let value = objc_getAssociatedObject(self, &aKey) as? Ando {
            return value
        } else {
            let temp = Ando()
            temp.callback = { [weak self] response in
                guard response.error == nil else {
                    print(response.error.debugDescription)
                    return
                }
                if let img = response.item as? UIImage {
                    DispatchQueue.main.async {
                        self?.image = img
                    }
                }
            }
            objc_setAssociatedObject(self, &aKey, temp, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            return temp
        }
    }
}
