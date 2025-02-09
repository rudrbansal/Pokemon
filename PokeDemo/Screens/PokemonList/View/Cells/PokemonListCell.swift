//
//  PokemonListCell.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import UIKit

final class PokemonListCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var title: UILabel!
    @IBOutlet var icon: UIImageView!
    
    // MARK: - Exposed Methods

    func setupData(data: Pokemon) {
        title.text = data.name.uppercased()
    }
    
    func setupImage(image: UIImage){
        icon.image = image
    }
}
