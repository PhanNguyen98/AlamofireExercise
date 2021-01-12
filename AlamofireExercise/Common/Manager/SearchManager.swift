//
//  SearchManager.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 11/01/2021.
//

import Foundation

class SearchManager {
    static let shared = SearchManager()
    
    var listKeySearch = [String]()
    var listResult = [ListImage]()
    
    private init() {
    }
    
    func setData(keySearch: String, data: ListImage) {
        var check = false
        for item in listKeySearch {
            if keySearch == item {
                check = true
            }
        }
        
        if check == false && keySearch != "" {
            listKeySearch.append(keySearch)
            listResult.append(data)
        }
    }

}
