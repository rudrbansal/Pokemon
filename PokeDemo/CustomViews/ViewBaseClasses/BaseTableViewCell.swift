//
//  BaseTableViewCell.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Exposed Methods
    
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
}
