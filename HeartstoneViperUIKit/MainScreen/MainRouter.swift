//
//  MainRouter.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import Foundation
import UIKit

// Object
// Entry point

typealias EntryPoint = MainViewProtocol & UIViewController

protocol MainRouterProtocol {
    var entry: EntryPoint? { get set }
    var navigationController: UINavigationController? { get set }
    
    static func start(appDependency: AppDependency) -> MainRouterProtocol
    func navigateToDetail(withName name: String, andRace race: String, andImage image: UIImage?, attack: Int?, health: Int?)
}

class MainRouter: MainRouterProtocol {
    var entry: EntryPoint?
    var navigationController: UINavigationController?
    
    static func start(appDependency: AppDependency) -> MainRouterProtocol {
        let router = MainRouter()
        
        var view: MainViewProtocol = appDependency.container.resolve(MainViewProtocol.self)!
        var interactor: MainInteractorProtocol = appDependency.container.resolve(MainInteractorProtocol.self)!
        var presenter: MainPresenterProtocol = appDependency.container.resolve(MainPresenterProtocol.self)!
        
        view.mainPresenter = presenter
        interactor.mainPresenter = presenter
        presenter.mainRouter = router
        presenter.mainIntercator = interactor
        presenter.mainView = view
        
        router.entry = view as? EntryPoint
        router.navigationController = view as? UINavigationController
        
        return router
    }
    
    func navigateToDetail(withName name: String, andRace race: String, andImage image: UIImage?, attack: Int?, health: Int?) {
            let detailRouter = DetailScreenRouter.startDetail(name: name, race: race, image: image, attack: attack, health: health)
        guard let detailView = detailRouter.entry else {
            print("Cannot find detail router")
            return
        }
        navigationController?.pushViewController(detailView, animated: true)
    }
}
