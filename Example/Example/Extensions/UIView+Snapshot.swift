//
//  UIView+Snapshot.swift
//  Example
//
//  Created by Alper KARATAŞ on 25/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit

public extension UIView {
    public func snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImage
    }
    
    public func snapshotView() -> UIView? {
        if let snapshotImage = snapshotImage() {
            return UIImageView(image: snapshotImage)
        } else {
            return nil
        }
    }
}
