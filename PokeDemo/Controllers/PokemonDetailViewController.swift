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

    private let presenter = PokemonDetailPresenter(service: Service.shared)

    // MARK: Public

    var pokemonName: String!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pokemonName.uppercased()
        presenter.setViewDelegate(delegate: self)
        getPokemonDetails()
    }
    
    // MARK: - API methods
    
    private func getPokemonDetails() {
        presenter.getPokemonDetail(name: self.pokemonName)
    }
}

extension PokemonDetailViewController: PokemonDetailViewPresenterDelegate {
    func showPokemonDetail(pokemon: SpriteDetail) {
        let data = try? Data(contentsOf: URL(string: pokemon.front_default!)!)
        pokemonImageView.image = UIImage(data: data!)
    }
    
    func showAlert(title: String, message: String) {
        AlertUtility.shared.showAlert(self, title: "Error", message: message)
    }
}
