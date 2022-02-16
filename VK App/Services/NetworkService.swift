//
//  NetworkService.swift
//  VK App
//
//  Created by Asset Ryskul on 15.02.2022.
//

import Foundation
import Alamofire

final class NetworkService {
    
    // https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
    
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        
        return constructor
    }()
    let session = URLSession.shared
    
    func fetchFriends() {
        var constructor = urlConstructor
        constructor.path = "/method/friends.get"
        constructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.instance.userID)"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        
        guard let url = constructor.url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments)
            print(json)
        }
        task.resume()
    }
    
    func fetchFriendPhotos(_ id: String) {
        //id = 5634838
        var constructor = urlConstructor
        constructor.path = "/method/photos.getAll"
        constructor.queryItems = [
            URLQueryItem(name: "owner_id", value: id),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "need_hidden", value: "1"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        
        guard let url = constructor.url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments)
            print(json)
        }
        task.resume()
    }
    
    func fetchGroups() {
        var constructor = urlConstructor
        constructor.path = "/method/groups.get"
        constructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.instance.userID)"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        
        guard let url = constructor.url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments)
            print(json)
        }
        task.resume()
    }
    
    func fetchSearchGroups(_ searchText: String) {
        var constructor = urlConstructor
        constructor.path = "/method/groups.search"
        constructor.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        
        guard let url = constructor.url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments)
            print(json)
        }
        task.resume()
    }
    
    // Alamofire method
    func fetchSearchGroupsAF(_ searchText: String) {
        urlConstructor.path = "/method/groups.search"
        guard let url = urlConstructor.url else { return }
        let parameters: Parameters = [
            "q": searchText,
            "access_token": Session.instance.token,
            "count": 10,
            "v": "5.131"
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: parameters)
            .responseJSON { json in
                print(json)
            }
    }

}

