//
//  MainPresenter.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import Foundation
import UIKit

// object
// protocol
// ref to interacter, router and view

// 1. Презентер через роутер делал навигацию +
// 2. Данные во вью передавались через роутер +
// 3  Сделаьть Network все детали реализиции взаимодействия с апи +
// 3. Кэш данных второго экрана (в нетворке сделать)
// 4. Использовать нетворк в интеракторе +
// 5. DI IOC контейнер - подключить

protocol MainPresenterProtocol {
    
    var mainIntercator: MainInteractorProtocol? { get set }
    var mainRouter: MainRouterProtocol? { get set }
    var mainView: MainViewProtocol? { get set }
    
    func interactorDidFetchData(with result: Result<[Cards], Error>)
    func didSelectCard(name: String, race: String, image: UIImage?)
    func setNavigationController(_ navigationController: UINavigationController?)
}

class MainPresenter: MainPresenterProtocol {
    
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
    
    func didSelectCard(name: String, race: String, image: UIImage?) {
        mainRouter?.navigateToDetail(withName: name, andRace: race, andImage: image)
    }
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        mainRouter?.navigationController = navigationController
    }
}

