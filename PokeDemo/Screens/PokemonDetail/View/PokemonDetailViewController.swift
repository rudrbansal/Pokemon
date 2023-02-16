//
//  PokemonDetailViewController.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 16/02/23.
//
// MARK: - Navigation

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    // MARK: - Properties
    
    // MARK: - Private
    
    // MARK: Public
    
    var pokemon: Pokemon!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pokemon.name.uppercased()
    }
    
    // MARK: - API methods
}
