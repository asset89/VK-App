//
//  RealmFriend.swift
//  VK App
//
//  Created by Asset Ryskul on 28.02.2022.
//

import Foundation
import RealmSwift

class RealmFriend: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var photo200orig: String = ""
}

extension RealmFriend {
    convenience init(
        friend: Friend) {
            self.init()
            self.id = friend.id
            self.firstName = friend.firstName
            self.lastName = friend.lastName
            self.photo200orig = friend.photo200orig
    }
}
