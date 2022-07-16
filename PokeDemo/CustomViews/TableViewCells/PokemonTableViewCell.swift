//
//  PokemonTableViewCell.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import UIKit

class PokemonTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupData(data: Pokemon) {
        lblTitle.text = data.name?.uppercased()
    }
}
