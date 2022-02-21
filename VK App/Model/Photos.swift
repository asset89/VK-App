//
//  Photos.swift
//  VK App
//
//  Created by Asset Ryskul on 21.02.2022.
//

import Foundation

struct PhotoItem {
    let items: [PhotoSizes]
    
}

extension PhotoItem: Codable {
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct PhotoSizes {
    let sizes: [Photos]
    var like: Bool = false
}

extension PhotoSizes: Codable {
    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

struct Photos {
    let url: String
}

extension Photos: Codable {
    enum CodingKeys: String, CodingKey {
        case url
    }
}
