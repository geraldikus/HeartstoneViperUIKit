//
//  DetailScreenInteractor.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 13.03.24.
//

import Foundation

protocol DetailInteractorProtocol {
    
    var detailPresenter: DetailPresenterProtocol? { get set }
    
    func getImage(with id: String)
}

class DetailScreenInteractor: DetailInteractorProtocol {
    var detailPresenter: DetailPresenterProtocol?
    
    
    func getImage(with id: String) {
        print("")
    }
}
