//
//  PokemonDetailViewController.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//
// MARK: - Navigation

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    // MARK: - Properties
    
    private let pokemonDetailViewModel = PokemonDetailViewModel()
    var pokemonName: String!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pokemonName.uppercased()
        getPokemonDetails()
    }
    
    // MARK: - API methods
    
    private func getPokemonDetails() {
        
        pokemonDetailViewModel.getPokemonDetail(pokemonName: ("/" + pokemonName + "/")) {[weak self] success, error in
            guard let strongSelf = self else { return }
            if success ?? false {
                let url = URL(string: strongSelf.pokemonDetailViewModel.imageURL!)
                let data = try? Data(contentsOf: url!)
                strongSelf.pokemonImageView.image = UIImage(data: data!)
            } else {
                AlertUtility.showAlert(strongSelf, title: AlertUtility.AlertTitles.error, message: error?.localizedDescription)
            }
        }
    }
}
