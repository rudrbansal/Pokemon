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
        service.sendRequestWithJSON(endpoint: pokemon.url!, method: .get) { response, error in
            if error == nil {
                do {
                    guard let data = response as? Data else {
                        completion(nil)
                        return
                    }
                    let sprite = try JSONDecoder().decode(Sprite.self, from: data)
                    guard let frontValue = sprite.sprites?.front_default,
                          let url = URL(string: frontValue) else {
                        completion(nil)
                        return
                    }
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let imageData = data else { return }
                        completion(UIImage(data: imageData))
                    }.resume()
                }
                catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    // MARK: Private method(s)
    
    private func getPokemons() {
        service.sendRequestWithJSON(endpoint: Endpoints.shared.baseURL, method: .get) {[weak self] response, error in
            guard let self = self else { return }
            if error == nil {
                do {
                    let pokemonResult = try JSONDecoder().decode(PokemonResult.self, from: response as! Data)
                    self.delegate?.show(pokemonResult.results!)
                }
                catch {
                    // Show alert that something is wrong with server
                    self.delegate?.showAlert(title: Constants.error, message: error.localizedDescription)
                }
            } else if !Internet.shared.isAvailable() {
                self.delegate?.showAlert(title: Constants.error, message: Internet.shared.noInternet)
            } else {
                // if error is network error - Show no internet connection alert
                // else: Show general error alert
                self.delegate?.showAlert(title: Constants.error, message: error?.localizedDescription ?? "Sorry, something went wrong")
            }
        }
    }
}
