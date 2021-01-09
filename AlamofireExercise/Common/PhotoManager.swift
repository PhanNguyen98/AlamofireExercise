//
//  PhotoManager.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 05/01/2021.
//

import Foundation
import Alamofire
import SVProgressHUD
import Kingfisher

class PhotoManager {
    static let shared = PhotoManager()
    private init() {
    }
    
    func getListImage(completionHandler: @escaping (_ result: Result<[ImageModel]?, ResponseError>) -> ()) {
        APIManager.shared.call(type: ImageAPI.getRandomImage) { (result: Result<[ImageModel]?, ResponseError>) in
            switch result {
            case .success(let image):
                completionHandler(.success(image))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getListTopic(completionHandler: @escaping (_ result: Result<[TopicModel]?, ResponseError>) -> ()) {
        APIManager.shared.call(type: ImageAPI.getListTopic) { (result: Result<[TopicModel]?, ResponseError>) in
            switch result {
            case .success(let list):
                completionHandler(.success(list))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func searchImage(name: String, completionHander: @escaping (_ result: Result<ListImage?, ResponseError>) -> () ) {
        APIManager.shared.call(type: ImageAPI.search(name)) { (result: Result<ListImage?, ResponseError>) in
            switch result {
            case .success(let result):
                completionHander(.success(result))
            case .failure(let error):
                completionHander(.failure(error))
            }
        }
    }
    
    func loadImage(url: String, image: UIImageView) {
        let url = URL(string: url)
        image.kf.indicatorType = .activity
        image.kf.setImage(with: url)
    }
    
}
