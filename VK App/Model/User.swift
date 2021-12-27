//
//  User.swift
//  VK App
//
//  Created by Asset Ryskul on 22.12.2021.
//

import Foundation

enum Array_element {
    case friend
    case group
}

class User {
    
    var id: Int = 0
    var name: String = "My Name"
    var avatar: String = ""
    var yearOfBirth: Int = 1999
    var friends: [Friend] = []
    var groups: [Group] = []
    
    static var sharedInstance = User()
    init() {}
    
    func addElement<T>(element: T, array: Array_element) {
        switch array {
        case .friend:
            self.friends.append(element as! Friend)
        case .group:
            self.groups.append(element as! Group)
        }
    }
    
    /*func addGroup(group: Group) {
        self.groups.append(group)
    }*/
    
    func deleteGroup(group: Group) {
        if let index = self.groups.firstIndex(where: { $0.id == group.id }) {
            self.groups.remove(at: index)
        }
    }

}
