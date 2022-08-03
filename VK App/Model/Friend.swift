//
//  Friend.swift
//  VK App
//
//  Created by Asset Ryskul on 26.12.2021.
//

import Foundation

struct FriendItem {
    let items: [Friend]
}

extension FriendItem: Codable {
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct Friend {
    let id: Int
    let firstName: String
    let lastName: String
    let photo200orig: String
}

extension Friend: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo200orig = "photo_200_orig"
    }
}
