//
//  MainPresenter.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import Foundation

// object
// protocol
// ref to interacter, router and view

protocol MainPresenterProtocol {
    
    var mainIntercator: MainInteractorProtocol? { get set }
    var mainRouter: MainRouterProtocol? { get set }
    var mainView: MainViewProtocol? { get set }
    
//    var network: NetworkProtocol? { get set }
    
    func interactorDidFetchData(with result: Result<[Cards], Error>)
}

class MainPresenter: MainPresenterProtocol {
    
    
//    var network: NetworkProtocol? {
//        didSet {
//            network?.getData(races: "races", endpoints: Endpoints.beast, id: nil)
//            network?.getData(races: "", endpoints: Endpoints.beast, id: nil)
//        }
//    }
    
    // 1. Презентер через роутер делал навигацию
    // 2. Данные во вью передавались через роутер
    // 3  Сделаьть Network все детали реализиции взаимодействия с апи
    // 3. Кэш данных второго экрана (в нетворке сделать)
    // 4. Использовать нетворк в интеракторе
    // 5. DI IOC контейнер - подключить
    
    var mainRouter: MainRouterProtocol?
    
    var mainView: MainViewProtocol?

    var mainIntercator: MainInteractorProtocol? {
        didSet {
            mainIntercator?.getdata(for: RacesEndpoints.beast)
            mainIntercator?.getdata(for: RacesEndpoints.demon)
            mainIntercator?.getdata(for: RacesEndpoints.dragon)
            mainIntercator?.getdata(for: RacesEndpoints.murloc)
        }
    }
    
    func interactorDidFetchData(with result: Result<[Cards], Error>) {
        switch result {
        case .success(let cards):
            print("Data is ok.")
            mainView?.updateData(with: cards)
        case .failure(let error):
            print("Error in interactorDidFetchData: \(error)")
        }
    }
}

