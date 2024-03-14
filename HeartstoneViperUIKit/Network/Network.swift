//
//  Network.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 12.03.24.
//

import Foundation
import Alamofire

// 3. Сделать в Netwrok все детали взаисодействия с API

// Я перенес сюда базовый url и хедеры. (Хедеры везде одинаковые в этом апи)
// И сделал метод по которому я буду загружать данные.

protocol NetworkProtocol {
    func request(endpoint: String, shouldCache: Bool, completion: @escaping (Result<Data, Error>) -> Void)
}

final class Network: NetworkProtocol {
    
    let baseURL = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/"
    let headers: HTTPHeaders = [
        "X-RapidAPI-Key": "6f7c12bfe7msheef9f26bb3dc196p19f87cjsn5b15ab876cd2",
        "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
    ]
    
    private let dataCache = NSCache<NSString, NSData>()
    
    func request(endpoint: String, shouldCache: Bool, completion: @escaping (Result<Data, Error>) -> Void) {
        
        // Тут endpoint может быть любой строкой. То есть если в будущем нам придется загружать
        // данный по id, то можно подставить его или любые другие данные.
        // Также сделал кэш. Теперь, когда мы будем обращаться в интеракторе к сетевому классу,
        // нам достаточно будет указать, нужно нам кэширование или нет
        
        let fullURL = baseURL + endpoint
        
        if shouldCache, let cachedData = dataCache.object(forKey: fullURL as NSString) {
            print("Returning cached data for \(fullURL)")
            completion(.success(cachedData as Data))
            return
        }
        
        AF.request(fullURL, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                if shouldCache {
                    self.dataCache.setObject(data as NSData, forKey: fullURL as NSString)
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
