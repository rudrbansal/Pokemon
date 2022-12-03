//
//  PokemonTableViewCell.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import UIKit

class PokemonTableViewCell: BaseTableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - Exposed Methods

    func setupData(data: Pokemon) {
        lblTitle.text = data.name?.uppercased()
    }
    
    func setupImage(image: UIImage){
        iconImageView.image = image
    }
}
