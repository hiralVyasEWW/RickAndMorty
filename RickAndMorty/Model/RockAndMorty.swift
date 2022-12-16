//
//  CollectionView.swift
//  RickAndMorty
//
//  Created by Hiral Vyas on 12/12/22.
//

import Foundation
import UIKit

struct RockAndMorty : Codable {
    let info: CharacterApiInfo
    let results : [Information]
}

struct CharacterApiInfo : Codable {
    let count : Int
    let pages : Int
   let next, prev : String?
}

struct Information : Codable {
    let id : Int
    var name, image : String?
    let gender: Gender?
    let species: String?
    let status: CharacterStatus?
    let origin : Origin?
    let episode : [String]?
    
}

struct Origin: Codable {
    let name, url : String
}

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
    case unknownGender = "unknown"
}

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknownStatus = "unknown"
}

extension CharacterStatus {
    
    var color: UIColor {
        switch self {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknownStatus:
            return .gray
        }
    }
    
}
