//
//  MainInteractor.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import Foundation
import Alamofire

// object
// protocol
// ref to presenter
// get data or smt like that

protocol MainInteractorProtocol {
    var mainPresenter: MainPresenterProtocol? { get set }
    func getdata(for race: Endpoints)
}

class MainInteractor: MainInteractorProtocol {
    
    var mainPresenter: MainPresenterProtocol?
    
    private func createURL(for race: Endpoints) -> String {
       // let baseURL = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/races/"
        let baseURL = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cardbacks"
        let url = baseURL + race.rawValue
        return url
    }
    
    func getdata(for race: Endpoints) {
        print("Start fetching data")
        
        let url = createURL(for: race)
        
//        let headers: HTTPHeaders = [
//            "X-RapidAPI-Key": "6f7c12bfe7msheef9f26bb3dc196p19f87cjsn5b15ab876cd2",
//            "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
//        ]
        
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": "6f7c12bfe7msheef9f26bb3dc196p19f87cjsn5b15ab876cd2",
            "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
        ]
        
        AF.request(url, headers: headers).validate()
            .response { response in
                guard let data = response.data else {
                    self.mainPresenter?.interactorDidFetchData(with: .failure(FetchError.failed), for: race)
                    print("Cannot find data")
                    return
                }
                
                do {
                    let entities = try JSONDecoder().decode([Cards].self, from: data)
                    self.mainPresenter?.interactorDidFetchData(with: .success(entities), for: race)
                }
                catch {
                    self.mainPresenter?.interactorDidFetchData(with: .failure(error), for: race)
                }
                
            }
    }
}

