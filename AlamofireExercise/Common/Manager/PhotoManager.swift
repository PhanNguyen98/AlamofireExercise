//
//  PhotoManager.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 05/01/2021.
//

import Foundation
import Alamofire
import Kingfisher

class PhotoManager {
    static let shared = PhotoManager()
    private init() {
    }
    
    //Get random image with parameter count
    func getListRandomImage(count: Int, completionHandler: @escaping (_ result: Result<[ImageModel]?, ResponseError>) -> ()) {
        APIManager.shared.call(type: ImageAPI.getRandomImage(count)) { (result: Result<[ImageModel]?, ResponseError>) in
            switch result {
            case .success(let image):
                completionHandler(.success(image))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    //Get list topic image in parameter page
    func getListTopic(page: Int, completionHandler: @escaping (_ result: Result<[TopicModel]?, ResponseError>) -> ()) {
        APIManager.shared.call(type: ImageAPI.getListTopic(page)) { (result: Result<[TopicModel]?, ResponseError>) in
            switch result {
            case .success(let list):
                completionHandler(.success(list))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    //Get list photos with parameter page
    func getListPhotos(page: Int, count: Int, completionHandler: @escaping (_ result: Result<[ImageModel]?, ResponseError>) -> ()) {
        APIManager.shared.call(type: ImageAPI.getListPhoto(page, count)) { (result: Result<[ImageModel]?, ResponseError>) in
            switch result {
            case .success(let list):
                completionHandler(.success(list))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    //Search image with parameter name in parameter Page
    func searchImage(name: String, page: Int, completionHander: @escaping (_ result: Result<ListImage?, ResponseError>) -> () ) {
        APIManager.shared.call(type: ImageAPI.search(name, page)) { (result: Result<ListImage?, ResponseError>) in
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
