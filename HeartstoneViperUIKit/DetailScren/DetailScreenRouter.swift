//
//  DetailScreenRouter.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 13.03.24.
//

import Foundation
import UIKit

typealias DetailEntryPoint = DetailViewProtocol & UIViewController

protocol DetailRouterProtocol {
    var entry: DetailEntryPoint? { get }
    
    static func startDetail(name: String, race: String) -> DetailRouterProtocol
}

class DetailScreenRouter: DetailRouterProtocol {
    
    var entry: DetailEntryPoint?
    
    static func startDetail(name: String, race: String) -> DetailRouterProtocol {
        let router = DetailScreenRouter()
        var view: DetailViewProtocol = DetailScreenViewController()
        view.name = name
        view.race = race
        var presenter: DetailPresenterProtocol = DetailScreenPresenter()
        var interactor: DetailInteractorProtocol = DetailScreenInteractor()
        view.detailPresenter = presenter
        interactor.detailPresenter = presenter
        presenter.detailRouter = router
        presenter.detailView = view
        presenter.detailInteractor = interactor
        
        router.entry = view as? DetailEntryPoint
        
        return router
    }
}
