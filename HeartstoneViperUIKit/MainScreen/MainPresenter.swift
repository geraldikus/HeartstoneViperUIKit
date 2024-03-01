//
//  MainPresenter.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import Foundation

// object
// protocol
// ref to interacter, router and view

protocol MainPresenterProtocol {
    
    var mainIntercator: MainInteractorProtocol? { get set }
    var mainRouter: MainRouterProtocol? { get set }
    var mainView: MainViewProtocol? { get set }
    
    func interactorDidFetchData(with result: Result<[Cards], Error>)
}

class MainPresenter: MainPresenterProtocol {
    
    var mainRouter: MainRouterProtocol?
    
    var mainView: MainViewProtocol?

    var mainIntercator: MainInteractorProtocol? {
        didSet {
            mainIntercator?.getdata(for: Endpoints.beast)
            mainIntercator?.getdata(for: Endpoints.demon)
            mainIntercator?.getdata(for: Endpoints.dragon)
            mainIntercator?.getdata(for: Endpoints.murloc)
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
}

