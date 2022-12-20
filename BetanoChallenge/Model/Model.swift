//
//  Model.swift
//  BetanoChallenge
//
//  Created by Masam Mahmood on 14/12/2022.
//

import Foundation

// MARK: - SportElement
struct SportElement: Codable {
    let i: TeamType
    let d: String
    var e: [TeamsElement]
    var isExpand: Int?
    
}

// MARK: - TeamsElement
struct TeamsElement: Codable {
    let d, i: String
    let si: TeamType
    let sh: String
    let tt: Int64
    var sortType : Bool
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        d = try values.decodeIfPresent(String.self, forKey: .d)!
        i = try values.decodeIfPresent(String.self, forKey: .i)!
        si = try values.decodeIfPresent(TeamType.self, forKey: .si)!
        sh = try values.decodeIfPresent(String.self, forKey: .sh)!
        tt = try values.decodeIfPresent(Int64.self, forKey: .tt)!
                
        do {
            sortType = try values.decodeIfPresent(Bool.self, forKey: .sortType) ?? false
        } catch DecodingError.typeMismatch {
            sortType = try Bool(values.decodeIfPresent(Bool.self, forKey: .sortType) ?? false)
        }
        
    }
    
    //static func <(lhs: TeamsElement, rhs: TeamsElement) -> Bool {
     //   return lhs.sortType < rhs.sortType
    //}
}

enum TeamType: String, Codable {
    case badm = "BADM"
    case bask = "BASK"
    case esps = "ESPS"
    case foot = "FOOT"
    case hand = "HAND"
    case iceh = "ICEH"
    case snoo = "SNOO"
    case tabl = "TABL"
    case tenn = "TENN"
    case voll = "VOLL"
}

typealias Sport = [SportElement]
