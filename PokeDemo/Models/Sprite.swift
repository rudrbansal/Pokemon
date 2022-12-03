//
//  Sprite.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 06/07/22.
//

import Foundation

struct Sprite: Decodable {
    var name: String?
    var id: Int?
    var sprites: SpriteDetail?
}

struct SpriteDetail: Decodable {
    var front_default: String?
}
