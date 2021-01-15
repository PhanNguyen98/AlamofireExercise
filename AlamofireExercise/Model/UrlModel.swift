//
//  UrlModel.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 13/01/2021.
//

import Foundation

struct UrlModel: Codable {
    var urls: Urls
}

struct Urls: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}

struct UrlsProfileImage:Codable {
    var small: String
    var medium: String
    var large: String
}
