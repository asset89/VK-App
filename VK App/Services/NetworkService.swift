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
    
    func fetchFriends(completion: @escaping (Result<Response<FriendItem>, Error>) -> Void) {
        var constructor = urlConstructor
        constructor.path = "/method/friends.get"
        constructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.instance.userID)"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "photo_200_orig"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        guard let url = constructor.url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard error == nil, let data = data else { return }
            do {
                let friendResponse = try JSONDecoder().decode(Response<FriendItem>.self, from: data)
                completion(.success(friendResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchFriendPhotos(_ id: String, completion: @escaping (Result<Response<PhotoItem>, Error>) -> Void) {
        var constructor = urlConstructor
        constructor.path = "/method/photos.getAll"
        constructor.queryItems = [
            URLQueryItem(name: "owner_id", value: id),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "no_service_albums", value: "0"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "photo_sizes", value: "1"),
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
            do {
                let photoResponse = try JSONDecoder().decode(Response<PhotoItem>.self, from: data)
                completion(.success(photoResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchGroups(completion: @escaping (Result<Response<GroupItem>, Error>) -> Void) {
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
            do {
                let groupResponse = try JSONDecoder().decode(Response<GroupItem>.self, from: data)
                completion(.success(groupResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchSearchGroups(_ searchText: String, completion: @escaping (Result<Response<GroupItem>, Error>) -> Void) {
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
            do {
                let groupResponse = try JSONDecoder().decode(Response<GroupItem>.self, from: data)
                completion(.success(groupResponse))
            } catch {
                completion(.failure(error))
            }
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
    
    func fetchNews(completion: @escaping (Result<Response<NewsItems>, Error>) -> Void) {
        var constructor = urlConstructor
        constructor.path = "/method/newsfeed.get"
        constructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.instance.userID)"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "filters", value: "post"),
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
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let newsResponse = try JSONDecoder().decode(Response<NewsItems>.self, from: data)
                    completion(.success(newsResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func fetchGroupById(id: Int, completion: @escaping (Result<Response<[Group]>, Error>) -> Void) {
        var constructor = urlConstructor
        constructor.path = "/method/groups.getById"
        constructor.queryItems = [
            URLQueryItem(name: "group_id", value: "\(-1*id)"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                do {
                    let groupResponse = try JSONDecoder().decode(Response<[Group]>.self, from: data)
                    completion(.success(groupResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

}

