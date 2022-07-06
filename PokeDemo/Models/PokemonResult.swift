//
//  Pokemon.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import Foundation

struct PokemonResult: Decodable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Pokemon]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }
}
