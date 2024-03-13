//
//  DetailScreenPresenter.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 13.03.24.
//

import Foundation

protocol DetailPresenterProtocol {
    
    var detailInteractor: DetailInteractorProtocol? { get set }
    var detailRouter: DetailRouterProtocol? { get set }
    var detailView: DetailViewProtocol? { get set }
    
    func interactorFetchData()
}

class DetailScreenPresenter: DetailPresenterProtocol {
    
    var detailInteractor: DetailInteractorProtocol?
    var detailRouter: DetailRouterProtocol?
    var detailView: DetailViewProtocol?
    
    func interactorFetchData() {
        
    }
}
