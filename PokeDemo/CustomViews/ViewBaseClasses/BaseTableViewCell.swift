//
//  BaseTableViewCell.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    class func cellIdentifier() -> String {
        return String(describing: self)
    }
}
