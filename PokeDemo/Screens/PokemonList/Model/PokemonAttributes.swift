//
//  Sprite.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 06/07/22.
//

import Foundation

struct PokemonAttributes: Decodable {
    var name: String
    var id: Int
    var attributes: PokemonImageAttribute
    var types: [TypeElement]
    let height: Int
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case attributes = "sprites"
        case types
        case height
        case weight
    }
}

struct TypeElement: Decodable {
    let slot: Int
    let type: Pokemon
}
