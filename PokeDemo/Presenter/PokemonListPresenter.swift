//
//  PokemonListPresenter.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 15/07/22.
//

import Foundation
import UIKit

protocol PokemonListPresenterDelegate: AnyObject {
    func show(_ pokemons: [Pokemon])
    func showAlert(title: String, message: String)
}

typealias PokemonListViewPresenterDelegate = PokemonListPresenterDelegate & UIViewController

final class PokemonListPresenter {
    
    // MARK: Properties
    
    // MARK: Public
    
    weak var delegate: PokemonListViewPresenterDelegate?
    
    // MARK: Private
    
    private let service: ServiceRepresentable
    
    // MARK: Initailizers
    
    init(service: ServiceRepresentable = Service.shared) {
        self.service = service
    }
    
    // MARK: Exposed methods
    
    func viewDidLoad() {
        getPokemons()
    }
    
    func setViewDelegate(delegate: PokemonListViewPresenterDelegate) {
        self.delegate = delegate
    }
    
    func didSetupCellWith(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void) {
        service.sendRequestWithJSON(endpoint: pokemon.url, method: .get) { response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            do {
                guard let data = response as? Data else {
                    completion(nil)
                    return
                }
                let attributes = try JSONDecoder().decode(PokemonAttributes.self, from: data)
                let frontValue = attributes.attributes.frontImage
                let url = URL(string: frontValue)
                URLSession.shared.dataTask(with: url ?? URL(fileURLWithPath: "")) { data, response, error in
                    guard let imageData = data else { return }
                    completion(UIImage(data: imageData))
                }.resume()
            }
            catch {
                completion(nil)
            }
        }
    }
    
    // MARK: Private method(s)
    
    private func getPokemons() {
        service.sendRequestWithJSON(endpoint: Endpoints.shared.baseURL, method: .get) {[weak self] response, error in
            guard let self = self else { return }
            guard error == nil else {
                self.delegate?.showAlert(title: Constants.error, message: error?.localizedDescription ?? "Sorry, something went wrong")
                return
            }
            do {
                guard let pokemonResponse = response else { return }
                let pokemonResult = try JSONDecoder().decode(PokemonResult.self, from: pokemonResponse as! Data)
                self.delegate?.show(pokemonResult.results)
            }
            catch {
                self.delegate?.showAlert(title: Constants.error, message: error.localizedDescription)
            }
        }
    }
}
