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
// 3  Сделаьть в Network все детали реализиции взаимодействия с апи +
// 4. Кэш данных второго экрана (в нетворке сделать) +
// 5. Использовать нетворк в интеракторе +
// 6. DI IOC контейнер - подключить +

// 4. Кэш данных второго экрана (в нетворке сделать)
// По этой задаче. Я сделал класс Network таким, что там можно выбрать, нужен ли нам кэш или нет.
// В моем случае я словил 429 ошибку от сервера, превышение лимитов.
// Поэтому я сделал так, загрузил данные один раз на главный экран, а потом эти же данные перенес на DetailView.
// Тем самым уменьшил количество запросов в сеть.

protocol MainPresenterProtocol {
    
    var mainIntercator: MainInteractorProtocol? { get set }
    var mainRouter: MainRouterProtocol? { get set }
    var mainView: MainViewProtocol? { get set }
    
    func interactorDidFetchData(with result: Result<[Cards], Error>)
    func didSelectCard(name: String, race: String, image: UIImage?, attack: Int?, health: Int?)
    func setNavigationController(_ navigationController: UINavigationController?)
}

class MainPresenter: MainPresenterProtocol {
    
    var mainRouter: MainRouterProtocol?
    var mainView: MainViewProtocol?
    var mainIntercator: MainInteractorProtocol?
    
    init(appDependency: AppDependency) {
        self.mainIntercator = appDependency.container.resolve(MainInteractorProtocol.self)
        self.mainIntercator?.mainPresenter = self
        
        self.mainIntercator?.getdata(for: .beast)
        self.mainIntercator?.getdata(for: .demon)
        self.mainIntercator?.getdata(for: .dragon)
        self.mainIntercator?.getdata(for: .murloc)
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
    
    func didSelectCard(name: String, race: String, image: UIImage?, attack: Int?, health: Int?) {
        mainRouter?.navigateToDetail(withName: name, andRace: race, andImage: image, attack: attack, health: health)
    }
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        mainRouter?.navigationController = navigationController
    }
}

