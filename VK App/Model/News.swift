//
//  News.swift
//  VK App
//
//  Created by Asset Ryskul on 05.04.2022.
//

import Foundation

struct NewsItems {
    let items: [NewsStruct]
}

extension NewsItems: Codable {
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct NewsStruct {
    let sourceId: Int
    let text: String
    let date: Date
    let attachments: [NewsPhotos]?
    let comments: NewsComments
    let likes: NewsLikes
    
}

extension NewsStruct: Codable {
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case text
        case attachments
        case likes
        case comments
    }
}

struct NewsPhotos{
    let photo: NewsPhoto?
}

extension NewsPhotos: Codable {
    enum CodingKeys: String, CodingKey {
        case photo
    }
}

struct NewsPhoto {
    let sizes: [NewsPhotoSize]
}

extension NewsPhoto: Codable {
    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

struct NewsPhotoSize {
    let url: String
    let width: Int
}

extension NewsPhotoSize: Codable {
    enum CodingKeys: String, CodingKey {
        case url
        case width
    }
}
    
struct NewsLikes{
    let count: Int
}

extension NewsLikes: Codable {
    enum CodingKeys: String, CodingKey {
        case count
    }
}
    
struct NewsComments {
    let count: Int
}

extension NewsComments: Codable {
    enum CodingKeys: String, CodingKey {
        case count
    }
}
