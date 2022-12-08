//
//  UITableViewCell.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import UIKit

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifying {}

