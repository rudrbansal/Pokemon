//
//  BaseViewController.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//
// MARK: - Navigation

import UIKit

class BaseViewController: UIViewController, ReuseIdentifying {
    
    // MARK: - Exposed Methods
    
    func moveToViewController(storyboard: String, destination: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: destination)
        return vc
    }
}
