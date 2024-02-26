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
    let type: String
    let cost: Int?
    let attack: Int?
    let health: Int?
    let text: String?
    let artist: String?
    let race: String?
    let playerClass: String?
    let img: String?
    let locale: String?
    let mechanics: [Mechanics]?
}

struct Mechanics: Codable, Hashable {
    let name: String
}

//struct CardBack: Codable, Hashable {
//    let cardBackId: Int
//    let name: String
//    let description: String
//    let source: String
//    let howToGet: String
//    let enabled: Bool
//    let img: String
//    let imgAnimated: String
//    let sortCategory: Int
//    let sortOrder: Int
//    let locale: String
//}

