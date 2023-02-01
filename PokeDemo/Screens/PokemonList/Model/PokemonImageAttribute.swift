//
//  PokemonImageAttribute.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 07/01/23.
//

import Foundation

struct PokemonImageAttribute: Decodable {
    var frontImage: String
    
    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
    }
}
