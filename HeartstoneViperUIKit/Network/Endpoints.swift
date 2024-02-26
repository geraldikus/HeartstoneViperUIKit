//
//  Endpoints.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import Foundation

enum Endpoints: String {
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
    
    static let allRaces: [Endpoints] = [.beast, .demon, .dragon, .elemental, .mech, .murloc, .pirate, .totem, .all, .general]
}
