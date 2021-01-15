//
//  UserModel.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 13/01/2021.
//

import Foundation

struct UserModel: Codable {
    var name: String
}

struct UserTopic: Codable {
    var user: UserModel
    var urls: Urls
}
