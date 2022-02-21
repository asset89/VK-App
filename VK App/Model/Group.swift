//
//  Group.swift
//  VK App
//
//  Created by Asset Ryskul on 23.12.2021.
//

import Foundation

struct GroupItem {
    let items: [Group]
}

extension GroupItem: Codable {
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct Group {
    let id: Int
    let name: String
    let photo200: String
}

extension Group: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo200 = "photo_200"
    }
}
