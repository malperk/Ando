//
//  DetailViewController.swift
//  Example
//
//  Created by Alper KARATAS on 5/24/17.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit
import Ando

private let reuseIdentifier = "DetailCell"

class DetailViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userImagesCollectionView: UICollectionView!
    
    var itemDetails: [UDRootClass] = []
    var selectedItem:RootClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userImagesCollectionView.dataSource = self
        self.userImagesCollectionView.delegate = self
        self.backgroundImageView.addParallax(30)
    }

    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DetailCollectionViewCell
        
        let item = self.itemDetails[indexPath.row]
        cell.assign(item: item)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        if let myCell = cell as? MainCollectionViewCell{
            myCell.userImageView.ando.cancel()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = self.itemDetails[indexPath.row];
        if let vc = self.destinationViewController as? BigImageViewController {
            vc.selectedItem = selectedItem
        }
    }
    
    // MARK: - Data Functions
    func getItems() {
        self.navigationItem.title = self.selectedItem?.user.username
        self.userImageView.ando.url = self.selectedItem?.user.profileImage.large ?? ""
        self.backgroundImageView.ando.url = self.selectedItem?.urls.small ?? ""
        let getData = Ando(type: .json)
        getData.callback = { [weak self] response in
            guard response.error == nil else {
                print(response.error.debugDescription)
                return
            }
            if let jsonItems = response.item as? [Any] {
                for jsonItem in jsonItems {
                    guard let jsonDict = jsonItem as? [String: Any] else {
                        continue
                    }
                    let item = UDRootClass.init(fromDictionary: jsonDict)
                    self?.itemDetails.append(item)
                }
            }
            DispatchQueue.main.async {
                HUD.shared.dismiss(animate: true)
                self?.userImagesCollectionView.reloadData()
            }
        }
        if let userPhotosurl = self.selectedItem?.user.links.photos {
            HUD.shared.show(animate: true)
            getData.url = userPhotosurl + clientId
        }
    }
}
