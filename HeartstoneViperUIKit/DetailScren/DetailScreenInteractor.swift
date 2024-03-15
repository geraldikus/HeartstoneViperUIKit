//
//  DetailScreenInteractor.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 13.03.24.
//

import Foundation

protocol DetailInteractorProtocol {
    
    var detailPresenter: DetailPresenterProtocol? { get set }
}

class DetailScreenInteractor: DetailInteractorProtocol {
    var detailPresenter: DetailPresenterProtocol?
}
