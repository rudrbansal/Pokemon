//
//  PokemonDetailViewController.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//
// MARK: - Navigation

import UIKit

class PokemonDetailViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    // MARK: - Properties
    
    // MARK: - Private
    
    private let presenter = PokemonDetailPresenter()
    
    // MARK: Public
    
    var pokemon: Pokemon!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pokemon.name?.uppercased()
        presenter.setViewDelegate(delegate: self)
        getPokemonDetails()
    }
    
    // MARK: - API methods
    
    private func getPokemonDetails() {
        presenter.getPokemonDetail(url: pokemon.url ?? "")
    }
}

extension PokemonDetailViewController: PokemonDetailViewPresenterDelegate {

    func showPokemonDetail(pokemon: SpriteDetail) {
        if let frontValue = pokemon.front_default,
           let url = URL(string: frontValue) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    self.pokemonImageView.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }
    
    func showAlert(title: String, message: String) {
        AlertUtility.shared.showAlert(self, title: Constants.error, message: message)
    }
}
