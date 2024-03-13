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
    
    static func start() -> MainRouterProtocol
    func navigateToDetail(withName name: String, andRace race: String)
}

class MainRouter: MainRouterProtocol {
    var entry: EntryPoint?
    var navigationController: UINavigationController?
    
    static func start() -> MainRouterProtocol {
        let router = MainRouter()
        
        var view: MainViewProtocol = MainViewController()
        var interactor: MainInteractorProtocol = MainInteractor()
        var presenter: MainPresenterProtocol = MainPresenter()
        
        view.mainPresenter = presenter
        interactor.mainPresenter = presenter
        presenter.mainRouter = router
        presenter.mainIntercator = interactor
        presenter.mainView = view
        
        router.entry = view as? EntryPoint
        router.navigationController = view as? UINavigationController
        
        return router
    }
    
    func navigateToDetail(withName name: String, andRace race: String) {
        let detailRouter = DetailScreenRouter.startDetail(name: name, race: race)
        guard let detailView = detailRouter.entry else {
            print("Cannot find detail router")
            return
        }
        navigationController?.pushViewController(detailView, animated: true)
    }
}
