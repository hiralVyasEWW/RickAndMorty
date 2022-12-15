//
//  CollectionView.swift
//  RickAndMorty
//
//  Created by Hiral Vyas on 12/12/22.
//

import Foundation

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
    let species: Species?
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

enum Species: String, Codable, CaseIterable {
    case human = "Human"
    case alien = "Alien"
    case unknownSpecies = "unknown"
}
