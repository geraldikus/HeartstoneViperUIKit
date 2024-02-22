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
    func getdata(for race: Race)
}

class MainInteractor: MainInteractorProtocol {
    
    var mainPresenter: MainPresenterProtocol?
    
    private func createURL(for race: Race) -> String {
        let baseURL = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/races/"
        let url = baseURL + race.rawValue
        return url
    }
    
    func getdata(for race: Race) {
        print("Start fetching data")
        
        let url = createURL(for: race)
        
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": "6f7c12bfe7msheef9f26bb3dc196p19f87cjsn5b15ab876cd2",
            "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
        ]
        
        AF.request(url, headers: headers).validate()
            .response { response in
                guard let data = response.data else {
                    self.mainPresenter?.interactorDidFetchData(with: .failure(FetchError.failed))
                    print("Cannot find data")
                    return
                }
                
                do {
                    print("Data: \(data)")
                    print(String(data: data, encoding: .utf8))
                    let entities = try JSONDecoder().decode([Cards].self, from: data)
                    self.mainPresenter?.interactorDidFetchData(with: .success(entities))
                }
                catch {
                    self.mainPresenter?.interactorDidFetchData(with: .failure(error))
                }
                
            }
    }
}

enum Race: String {
    case beast = "Beast"
    case demon = "Demon"
    case dragon = "Dragon"
    case elemental = "Elemental"
    case mech = "Mech"
    case murloc = "Murloc"
    case pirate = "Pirate"
    case totem = "Totem"
    case all = "All"
    case general = "General"
    
    static let allRaces: [Race] = [.beast, .demon, .dragon, .elemental, .mech, .murloc, .pirate, .totem, .all, .general]
}

enum FetchError: Error {
    case failed
}
