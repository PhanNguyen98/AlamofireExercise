//
//  TopicModel.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 11/01/2021.
//

import Foundation

struct TopicModel: Codable {
    var title: String
    var profile: UserTopic
    var list: [UrlModel]
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case profile = "cover_photo"
        case list = "preview_photos"
    }
}
