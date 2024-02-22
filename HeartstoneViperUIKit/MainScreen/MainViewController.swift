//
//  ViewController.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import UIKit

// ViewController
// Protocol
// reference presenter

protocol MainViewProtocol {
    var mainPresenter: MainPresenterProtocol? { get set }
    
    func updateData(with cards: [Cards])
    func updateData(with error: [Error])
}

class MainViewController: UIViewController, MainViewProtocol {
    
    var mainPresenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    func updateData(with cards: [Cards]) {
        print("Got Demons")
    }
    
    func updateData(with error: [Error]) {
        
    }

}

