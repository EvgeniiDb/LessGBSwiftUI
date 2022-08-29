//
//  NetworkService.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 29.08.2022.
//

import UIKit

// Перечисление используемых нами методов из АПИ
enum apiMethods: String {
    case friendsGet = "/method/friends.get"
    case usersGet = "/method/users.get"
    case photosGetAll = "/method/photos.getAll"
    case groupsGet = "/method/groups.get"
    case groupsSearch = "/method/groups.search"
    case groupsJoin = "/method/groups.join"
    case groupsLeave = "/method/groups.leave"
    case newsGet = "/method/newsfeed.get"
    case setLike = "/method/likes.add"
    case removeLike = "/method/likes.delete"
}


enum httpMethods: String {
    case get = "GET"
    case post = "POST"
}


protocol NetworkManagerInterface {
    
    
    func request<T: Decodable>(method: apiMethods,
                               httpMethod: httpMethods,
                               params: [String: String],
                               completion: @escaping (Result<T, Error>) -> Void
    )
    
    
    func loadImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}


final class NetworkManager: NetworkManagerInterface {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    
    private let decoder = JSONDecoder()
    
    
    private let scheme = "https"
    private let host = "api.vk.com"
    
    func request<T: Decodable>(method: apiMethods,
                               httpMethod: httpMethods,
                               params: [String: String],
                               completion: @escaping (Result<T, Error>) -> Void
    ){
        
        
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        guard let token = UserDefaults.standard.object(forKey: "vkToken") as? String else {
            return
        }
        
      
        let url = configureUrl(token: token, method: method, httpMethod: httpMethod, params: params)
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let strongSelf = self else { return }
            guard let data = data else { return }
            
            do {
                let decodedData = try strongSelf.decoder.decode(T.self, from: data)
                completionOnMain(.success(decodedData))
            } catch {
                print(error)
                completionOnMain(.failure(error))
            }
            
        }.resume()
    }
    
    private func configureUrl(token: String,
                      method: apiMethods,
                      httpMethod: httpMethods,
                      params: [String: String]) -> URL {
    
        
        var queryItems = [URLQueryItem]()
        
        
        queryItems.append(URLQueryItem(name: "access_token", value: token))
        queryItems.append(URLQueryItem(name: "v", value: "5.131"))
        
        for (param, value) in params {
            queryItems.append(URLQueryItem(name: param, value: value))
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = method.rawValue
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            fatalError("URL is invalid")
        }
        
        return url
    }
    
    func loadImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        
        let completionOnMain: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let responseData = data, error == nil else {
                if let error = error {
                    completionOnMain(.failure(error))
                }
                return
            }
            completionOnMain(.success(responseData))
        }).resume()
    }
}

