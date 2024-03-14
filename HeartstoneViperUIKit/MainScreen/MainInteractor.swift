//
//  MainInteractor.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import Foundation
import Alamofire

// object
// protocol
// ref to presenter
// get data or smt like that


// 4. Использовать нетворк в интеракторе
// Тут через протокол я обращаюсь к классу Network и использую оттуда метод request

protocol MainInteractorProtocol {
    var mainPresenter: MainPresenterProtocol? { get set }
    var network: NetworkProtocol? { get set }
    
    func getdata(for race: RacesEndpoints)
}

final class MainInteractor: MainInteractorProtocol {
    
    var mainPresenter: MainPresenterProtocol?
    var network: NetworkProtocol?
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func getdata(for race: RacesEndpoints) {
        print("Start fetching data")
        
        network?.request(endpoint: race.rawValue, shouldCache: false) { result in
            switch result {
            case .success(let data):
                do {
                    let entities = try JSONDecoder().decode([Cards].self, from: data)
                    self.mainPresenter?.interactorDidFetchData(with: .success(entities))
                } catch {
                    self.mainPresenter?.interactorDidFetchData(with: .failure(error))
                }
            case .failure(let error):
                self.mainPresenter?.interactorDidFetchData(with: .failure(error))
            }
        }
    }
}

