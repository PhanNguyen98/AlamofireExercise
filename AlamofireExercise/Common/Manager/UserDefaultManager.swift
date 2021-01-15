//
//  UserDefaultManager.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 14/01/2021.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
    let userManager = UserDefaults.standard
   
    private init() {
    }
    
    func setData(text: String) {
        var arrayData = [String]()
        arrayData = getData()
        if arrayData.first{ $0 == text } == nil {
            arrayData.append(text)
            userManager.setValue(arrayData, forKey: "ListKeySearch")
        }
    }
    
    func getData() -> [String] {
        guard let data: [String] = userManager.array(forKey: "ListKeySearch") as? [String] else {
            return [String]()
        }
        return data
    }
}
