//
//  Store.swift
//  SwiftyServer
//
//  Created by Jimmy Hoang on 2017-07-10.
//
//

import Foundation

class Store {
    
    private var storeDict:[String:String] = [:]
    
    init() {
        self.storeDict = UserDefaults.standard.dictionary(forKey: "storeDict") as! [String : String]
    }
    
    func set(key:String, value:String) {
        storeDict.updateValue(value, forKey: key)
        UserDefaults.standard.set(storeDict, forKey: "storeDict")
    }
    
    func get(key:String) -> String? {
        return storeDict[key]
    }
    
    func allItems() -> [String:String]? {
        return storeDict
    }
}
