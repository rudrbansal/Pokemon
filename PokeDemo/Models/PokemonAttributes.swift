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
    var attributes: ImageAttribute
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case attributes = "sprites"
    }
}

struct ImageAttribute: Decodable {
    var frontImage: String
    
    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
    }
}
