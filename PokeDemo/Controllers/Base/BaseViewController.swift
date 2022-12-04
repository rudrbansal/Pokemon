//
//  BaseViewController.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//
// MARK: - Navigation

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Exposed Methods
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    func moveToViewController(storyboard: String, destination: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: destination)
        return vc
    }
}
