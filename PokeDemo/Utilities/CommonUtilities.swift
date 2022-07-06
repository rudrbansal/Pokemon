//
//  CommonUtilities.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import Foundation
import UIKit

class CommonUtilities {
    
    class func moveToViewController(storyboard: String, destination: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: destination)
        return vc
    }
}
