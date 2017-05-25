//
//  MainCollectionView.swift
//  Example
//
//  Created by Alper KARATAŞ on 24/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit
import Ando

private let reuseIdentifier = "Cell"

class MainCollectionViewController: BaseCollectionViewController {
    var items: [RootClass] = []
    var selectedIndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getItems()
        ACache.shared.setMaxLenght(<#T##maxLenght: Int##Int#>)
    }


    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCollectionViewCell

        let item = self.items[indexPath.row]
        cell.assign(item: item)

        // Configure the cell

        return cell
    }

    // MARK: - UICollectionViewDelegate
    override public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        if let myCell = cell as? MainCollectionViewCell{
            myCell.userImageView.ando.cancel()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool{
        self.selectedIndexPath = indexPath
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = self.items[indexPath.row];
        if let vc = self.destinationViewController as? DetailViewController {
            vc.selectedItem = selectedItem
            vc.getItems()
        }
    }

    // MARK: - Data Functions
    func getItems() {
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
                    let item = RootClass.init(fromDictionary: jsonDict)
                    self?.items.append(item)
                }
            }
            DispatchQueue.main.async {
                HUD.shared.dismiss(animate: true)
                self?.collectionView?.reloadData()
            }
        }
        HUD.shared.show(animate: true)
        getData.url = endpoint

    }

}
