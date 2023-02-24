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
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var height: UILabel!
    @IBOutlet private var weight: UILabel!
    @IBOutlet private var types: UILabel!
    
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
        height.text = "\(pokemon.height) ft"
        weight.text = "\(pokemon.weight) kg"
        types.text = presenter.getPokemonTypes(types: pokemon.types)
        
    }
    
    func updateimage(image: UIImage) {
        imageView.image = image
    }
    
    func showAlert(title: String, message: String) {
        AlertUtility.shared.showAlert(self, title: "Error", message: message)
    }
}
