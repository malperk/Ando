//
//  BaseViewController.swift
//  Example
//
//  Created by Alper KARATAS on 5/24/17.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    var destinationViewController: UIViewController?
}

// MARK: - Navigation
extension BaseViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.destinationViewController = segue.destination
    }

}

class BaseCollectionViewController: UICollectionViewController {
    var destinationViewController: UIViewController?
}

// MARK: - Navigation
extension BaseCollectionViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.destinationViewController = segue.destination
    }
    
}
