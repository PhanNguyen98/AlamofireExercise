//
//  ResponseError.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 05/01/2021.
//

import Foundation

class ResponseError: Codable, Error {
    var errors: [String]
}
