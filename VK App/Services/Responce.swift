//
//  Responce.swift
//  VK App
//
//  Created by Asset Ryskul on 19.02.2022.
//

import Foundation

//struct Response<T:Codable>: Codable {
//    let response: T
//
//    enum CodingKeys: String, CodingKey {
//        case response
//    }
//}

struct Response<T: Codable>: Codable {
    let response: T
    
    enum CodingKeys: String, CodingKey {
        case response
    }
}
