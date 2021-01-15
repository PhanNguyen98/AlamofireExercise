//
//  ImageAPI.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 05/01/2021.
//

import Foundation
import Alamofire

enum ImageAPI {
    case getListTopic(_: Int)
    case getRandomImage(_: Int)
    case search(_: String, _: Int)
    case getListPhoto(_: Int, _: Int)
}

extension ImageAPI: TargetType {
    
    var baseURL: String {
        "https://api.unsplash.com/"
    }
    
    var path: String {
        switch self {
        case .getRandomImage:
            return "/photos/random"
        case .getListTopic:
            return "/topics"
        case .search:
            return "/search/photos"
        case .getListPhoto:
            return "/photos"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListTopic,
             .getRandomImage,
             .getListPhoto,
             .search:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.path)!
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getListTopic,
             .getRandomImage,
             .getListPhoto,
             .search:
            return URLEncoding.default
        }
    }
    
    var params: Parameters {
        switch self {
        case .getRandomImage(let count):
            return [
                "count" : count,
                "client_id" : SeverPath.upsplashAccessKey
            ]
        case .search(let name, let page):
            return [
                "page" : page,
                "query" : name,
                "client_id" : SeverPath.upsplashAccessKey
            ]
        case .getListTopic(let page):
            return [
                "page" : page,
                "client_id" : SeverPath.upsplashAccessKey
            ]
        case .getListPhoto(let page, let count):
            return [
                "page" : page,
                "per_page" : count,
                "client_id" : SeverPath.upsplashAccessKey
            ]
        }
    }
    
}
