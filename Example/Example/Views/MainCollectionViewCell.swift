//
//  MainCollectionViewCell.swift
//  Example
//
//  Created by Alper KARATAŞ on 24/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!

    var item: RootClass?

    func assign(item: RootClass) {
        self.item = item
        self.userImageView.ando.url = item.user.profileImage.large
        self.usernameLabel.text = item.user.username
    }
    //TODO: Add Parallax
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
}
