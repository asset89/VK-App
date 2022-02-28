//
//  RealmGroup.swift
//  VK App
//
//  Created by Asset Ryskul on 28.02.2022.
//

import Foundation
import RealmSwift

class RealmGroup: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var photo200: String = ""
}

extension RealmGroup {
    convenience init(
        group: Group) {
            self.init()
            self.id = group.id
            self.name = group.name
            self.photo200 = group.photo200
    }
}
