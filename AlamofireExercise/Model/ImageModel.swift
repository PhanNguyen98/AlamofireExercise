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

struct UrlsProfileImage:Codable {
    var small: String
    var medium: String
    var large: String
}

struct TopicModel: Codable {
    var title: String
    var profile: ImageModel
    var list: [ImageModel]
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case profile = "cover_photo"
        case list = "preview_photos"
    }
}

struct ListImage: Codable {
    var results: [ImageModel]
}

