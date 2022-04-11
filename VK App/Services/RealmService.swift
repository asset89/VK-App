//
//  RealmService.swift
//  VK App
//
//  Created by Asset Ryskul on 28.02.2022.
//

import Foundation
import RealmSwift

final class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    class func save<T:Object>(
        items: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy = .modified) throws {
            let realm = try Realm(configuration: configuration)
            print(configuration.fileURL ?? "")
            try realm.write {
                realm.add(
                    items,
                    update: update)
            }
        }
    
    class func load<T:Object>(typeOf: T.Type) throws -> Results<T> {
        let realm = try Realm()
        return realm.objects(T.self)
    }
    
    class func delete<T:Object>(object: Results<T>) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }
    
}
