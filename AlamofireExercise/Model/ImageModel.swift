//
//  ImageModel.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 05/01/2021.
//

import Foundation

struct ImageModel: Codable {
    var urls: Urls
    var user: UserModel
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

