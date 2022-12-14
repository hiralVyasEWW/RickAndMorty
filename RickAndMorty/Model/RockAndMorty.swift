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
    var name, status, gender, image : String?
    let origin : Origin?
    let episode : [String]?
    
}

struct Origin: Codable {
    let name, url : String
}

