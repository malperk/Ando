//
//  ACache.swift
//  Ando
//
//  Created by Alper KARATAŞ on 23/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

// I add another key
protocol CacheProtocol {
    func addItem(url: String, item: Any)
    func getItem(url: String) -> Any?
}

// I add another keys array because i want FIFO policy in my cache and swift dictionary not work like that. Please check this Apple document;

/// Removes and returns the first key-value pair of the dictionary if the
/// dictionary isn't empty.
///
/// ******* The first element of the dictionary is not necessarily the first element
/// added. Don't expect any particular ordering of key-value pairs. *******
///
/// - Returns: The first key-value pair of the dictionary if the dictionary
///   is not empty; otherwise, `nil`.
///
/// - Complexity: Averages to O(1) over many calls to `popFirst()`.
// public mutating func popFirst() -> (key: Key, value: Value)?

public class ACache: CacheProtocol {
    public static let shared = ACache()
    private var maxLenght = 100
    private var keys: [String] = []
    private var vals: [String: Any] = [:]

    func getItem(url: String) -> Any? {
        return vals[url]
    }

    func addItem(url: String, item: Any) {
        guard vals[url] == nil else {
            return
        }

        if self.keys.count > self.maxLenght && self.keys.count > 0 {
            let key = self.keys.removeFirst()
            self.vals.removeValue(forKey: key)
        }
        if self.maxLenght > 0 {
            self.keys.append(url)
            self.vals[url] = item }
    }

    public func setMaxLenght(_ maxLenght: Int) {
        guard maxLenght > 0 && self.keys.count > maxLenght else {
            self.maxLenght = maxLenght
            return
        }
        let diff = self.keys.count - maxLenght
        for _ in 0..<diff {
            let key = self.keys.removeFirst()
            self.vals.removeValue(forKey: key)
        }
        self.maxLenght = maxLenght
    }

}
