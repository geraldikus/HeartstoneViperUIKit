//
//  AppDependency.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 14.03.24.
//

import Swinject
import UIKit

// Тут я попытался сделать вот эту задачу: 6. DI IOC контейнер - подключить
// В методе setupDependencies я регистрирую все зависимости и вызываю этот метод в ините,
// тем самым выполняя этот метод при инициализации класса. А инициализирую я его в роутере
// в методе start, который потом вызываю в SceneDelegate.
// То есть AppDependency инициализируется и делает все зависимости при запуске приложения.

class AppDependency {
    let container = Container()

    init() {
        setupDependencies()
    }

    private func setupDependencies() {

        container.register(NetworkProtocol.self) { _ in Network() }
        
        container.register(MainInteractorProtocol.self) { _ in
            let interactor = MainInteractor(appDependency: self)
            return interactor
        }.inObjectScope(.container)

        container.register(MainPresenterProtocol.self) { r in
            let presenter = MainPresenter(appDependency: self)
            presenter.mainIntercator = r.resolve(MainInteractorProtocol.self)
            return presenter
        }.inObjectScope(.container)

        container.register(MainRouterProtocol.self) { r in
            let router = MainRouter()
            router.entry = r.resolve(MainViewProtocol.self) as? EntryPoint
            router.navigationController = r.resolve(MainViewProtocol.self) as? UINavigationController
            return router
        }
        
        container.register(MainViewProtocol.self) { r in
            let view = MainViewController()
            view.mainPresenter = r.resolve(MainPresenterProtocol.self)
            return view
        }
    }
}



