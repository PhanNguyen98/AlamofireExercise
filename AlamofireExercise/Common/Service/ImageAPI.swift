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
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListTopic,
             .getRandomImage,
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
             .search:
            return URLEncoding.default
        }
    }
    
    var params: Parameters {
        switch self {
        case .getRandomImage(let count):
            return [
                "count" : count,
                "client_id" : SeverPath.keyAccess
            ]
        case .search(let name, let page):
            return [
                "page" : page,
                "query" : name,
                "client_id" : SeverPath.keyAccess
            ]
        case .getListTopic(let page):
            return [
                "page" : page,
                "client_id" : SeverPath.keyAccess
            ]
        }
    }
    
}
