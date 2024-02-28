//
//  MainEntity.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import Foundation

struct Cards: Codable, Hashable {
    let cardId: String
    let dbfId: Int
    let name: String
    let cardSet: String
    let type: String?
    let cost: Int?
    let attack: Int?
    let health: Int?
    let text: String?
    let artist: String?
    let race: String // Мб ?
    let playerClass: String?
    let img: String?
    let locale: String?
    let mechanics: [Mechanics]?
}

struct Mechanics: Codable, Hashable {
    let name: String
}

//struct Cards: Codable, Hashable {
//    let cardId: String
//    let dbfId: Int
//    let name: String
//    let cardSet: String
//    let type: String
//    let cost: Int?
//    let attack: Int?
//    let health: Int?
//    let text: String?
//    let artist: String?
//    let race: String?
//    let playerClass: String?
//    let img: String?
//    let locale: String?
//    let mechanics: [Mechanics]?
//    
//    let raceType: Endpoints // Новое свойство для типа расы
//    
//    enum RaceType: String, CaseIterable {
//        case beast = "Beast"
//        case demon = "Demon"
//        case dragon = "Dragon"
//        case elemental = "Elemental"
//        case mech = "Mech"
//        case murloc = "Murloc"
//        case pirate = "Pirate"
//        case totem = "Totem"
//        case all = "All"
//        case general = "General"
//    }
//}
//
//struct Mechanics: Codable, Hashable {
//    let name: String
//}



