//
//  TopicModel.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 11/01/2021.
//

import Foundation

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

struct UrlsProfileImage:Codable {
    var small: String
    var medium: String
    var large: String
}
