//
//  CustomDetailSegue.swift
//  Example
//
//  Created by Alper KARATAŞ on 25/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit


//TODO: Add unwind
class CustomDetailSegue: UIStoryboardSegue {
    
    override func perform() {
        guard let firstVC = source as? MainCollectionViewController, let secondVC = destination as? DetailViewController else {
            return
        }
        let window = UIApplication.shared.keyWindow

        let userCell = firstVC.collectionView?.cellForItem(at: firstVC.selectedIndexPath)
        let frame = window?.convert(userCell!.frame, to: nil)
        let userImage = firstVC.collectionView?.cellForItem(at: firstVC.selectedIndexPath)!.snapshotView()
        userImage?.frame = frame!
        let secondFrame = secondVC.userImageView.frame
        
        window?.addSubview(userImage!)
        
        UIView.animate(withDuration: 1, animations: {
            userImage?.frame = secondFrame
        }) { _ in
            firstVC.navigationController?.pushViewController(secondVC, animated: false)
            userImage?.removeFromSuperview()
        }
        
    }
    
}
