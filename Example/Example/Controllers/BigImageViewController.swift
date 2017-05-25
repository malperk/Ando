//
//  BigImageViewController.swift
//  Example
//
//  Created by Alper KARATAS on 5/24/17.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit
import Ando

class BigImageViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainScrollView: UIScrollView!

    var selectedItem: UDRootClass?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainScrollView.minimumZoomScale = 1
        self.mainScrollView.maximumZoomScale = 6
        self.getImage()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mainImageView
    }
    
    // MARK: - Data Functions
    func getImage() {
        let getData = Ando(type: .image)
        getData.callback = { [weak self] response in
            guard response.error == nil else {
                print(response.error.debugDescription)
                return
            }
            if let image = response.item as? UIImage {
                DispatchQueue.main.async {
                    self?.mainImageView.image = image
                }
            }
            DispatchQueue.main.async {
                HUD.shared.dismiss(animate: true)
            }
        }
        if let imageUrl = self.selectedItem?.urls.full {
            HUD.shared.show(animate: true)
            getData.url = imageUrl
        }
    }
}
