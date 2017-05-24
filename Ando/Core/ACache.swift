//
//  ACache.swift
//  Ando
//
//  Created by Alper KARATAŞ on 23/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

class ACache {
    static let shared = ACache()
    private var maxLenght = 100
    private var cacheDict: [String:Any] = [:]

    func setMaxLenght(_ maxLenght: Int) {
        if self.maxLenght < maxLenght {
            self.maxLenght = maxLenght
        } else {
            let drop = self.cacheDict.count - maxLenght
            self.cacheDict = Dictionary(self.cacheDict.dropFirst(drop))
        }
    }
    func addItem(url: String, item: Any) {
        guard self.cacheDict[url] == nil else {
            return
        }

        if self.cacheDict.count == self.maxLenght {
            _ = self.cacheDict.dropFirst()
        }

        self.cacheDict[url] = item
    }
    func getItem(url: String) -> Any? {
        return self.cacheDict["url"]
    }
}
