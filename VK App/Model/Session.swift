//
//  Session.swift
//  VK App
//
//  Created by Asset Ryskul on 10.02.2022.
//

import Foundation

final class Session {
    
    static let instance = Session()
    
    private init() { }
    
    var token: String = ""
    var userID: Int = 0
}
