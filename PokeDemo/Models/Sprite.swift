//
//  Sprite.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 06/07/22.
//

import Foundation

struct Sprite: Decodable {
    
    var sprites: SpriteDetail?
    
    enum CodingKeys: String, CodingKey {
        case sprites = "sprites"
    }
}

struct SpriteDetail: Decodable {
    
    var front_default: String?
    
    enum CodingKeys: String, CodingKey {
        case front_default = "front_default"
    }
}
