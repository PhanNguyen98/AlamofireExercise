//
//  ImageModel.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 05/01/2021.
//

import Foundation

struct ImageModel: Codable {
    var urls: Urls
}

struct Urls: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}

struct ProfileImage: Codable {
    var profile: UrlsProfileImage
    enum CodingKeys: String, CodingKey {
        case profile = "profile_image"
    }
}

struct ListImage: Codable {
    var results: [ImageModel]
}

