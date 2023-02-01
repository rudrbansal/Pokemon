//
//  ReuseIdentifying.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 11/01/23.
//

import Foundation

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
