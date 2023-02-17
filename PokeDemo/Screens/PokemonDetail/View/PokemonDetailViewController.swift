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
    
    private let presenter = PokemonDetailPresenter(service: Service.shared)
    
    // MARK: Public
    
    var pokemon: Pokemon!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pokemon.name.uppercased()
        presenter.setViewDelegate(delegate: self)
        getPokemonDetails()
    }
    
    // MARK: - API methods
    private func getPokemonDetails() {
        presenter.getPokemonDetail(url: pokemon.url)
    }
}
extension PokemonDetailViewController: PokemonDetailViewPresenterDelegate {
    
    func showPokemonDetail(pokemon: PokemonAttributes) {
        if let frontValue = pokemon.attributes.frontImage as String? {
            presenter.fetchPokemonImageFrom(frontValue)
        }
    }
    
    func updateimage(image: UIImage) {
        pokemonImageView.image = image
    }
    
    func showAlert(title: String, message: String) {
        AlertUtility.shared.showAlert(self, title: "Error", message: message)
    }
}
