//
//  UIImageView+Ando.swift
//  Ando
//
//  Created by Alper KARATAŞ on 24/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

private var aKey: UInt8 = 0

// TODO: Check this again
public extension UIImageView {
    var ando: Ando {
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
        return temp
    }
}
