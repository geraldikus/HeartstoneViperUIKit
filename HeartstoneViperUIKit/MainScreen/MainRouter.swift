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
    
    static func start() -> MainRouterProtocol
}

class MainRouter: MainRouterProtocol {
    
    var entry: EntryPoint?
    
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
        
        return router
    }
}
