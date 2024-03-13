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
    func request(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class Network: NetworkProtocol {
    
    let baseURL = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/"
    let headers: HTTPHeaders = [
        "X-RapidAPI-Key": "6f7c12bfe7msheef9f26bb3dc196p19f87cjsn5b15ab876cd2",
        "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
    ]

    func request(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        // Тут endpoint может быть любой строкой. То есть если в будущем нам придется загружать
        // данный по id, то можно подставить его или любые другие данные.
        
        let url = baseURL + endpoint
        AF.request(url, headers: headers).validate()
            .response { response in
                switch response.result {
                case .success(_):
                    if let data = response.data {
                        completion(.success(data))
                    } else {
                        completion(.failure(FetchError.noData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}


