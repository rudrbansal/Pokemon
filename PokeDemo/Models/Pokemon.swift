//
//  Pokemon.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import Foundation

struct Pokemon: Decodable {
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
