//
//  ImageAPI.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 05/01/2021.
//

import Foundation
import Alamofire

enum ImageAPI {
    case getListTopic
    case getRandomImage
    case search(_: String)
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
        case .getRandomImage:
            return [
                "count" : 30,
                "client_id" : "fwHA-NlbjOi6lyrG2-P7nA4tvo1_QBlC6-gccdv34ks"
            ]
        case .search(let name):
            return [
                "page" : 1,
                "query" : name,
                "client_id" : "fwHA-NlbjOi6lyrG2-P7nA4tvo1_QBlC6-gccdv34ks"
            ]
        case .getListTopic:
            return [
                "page" : 3,
                "client_id" : "fwHA-NlbjOi6lyrG2-P7nA4tvo1_QBlC6-gccdv34ks"
            ]
        }
    }
    
}
