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
            mainIntercator?.getdata(for: Race.mech)
        }
    }
    
    func interactorDidFetchData(with result: Result<[Cards], Error>) {
        switch result {
        case .success(let cards):
            print("Datais ok. Cards: \(cards)")
        case .failure:
            print("Error in interactorDidFetchData")
        }
    }
}
