//
//  DetailCollectionViewCell.swift
//  Example
//
//  Created by Alper KARATAS on 5/24/17.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    
    var item: UDRootClass?
    
    func assign(item: UDRootClass) {
        self.item = item
        self.mainImageView.ando.url = item.urls.thumb
    }


}
