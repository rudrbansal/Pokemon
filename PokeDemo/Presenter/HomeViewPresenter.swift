//
//  HomeViewPresenter.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 15/07/22.
//

import Foundation
import UIKit

protocol HomeViewPresenterDelegate: AnyObject {
    func showPokemonList(pokemons: [Pokemon])
    func showAlert(title: String, message: String)
}

typealias HomePresenterDelegate = HomeViewPresenterDelegate & UIViewController

final class HomeViewPresenter {
    
    // MARK: Properties
    
    // MARK: Public
    
    weak var delegate: HomePresenterDelegate?

    // MARK: Private
    
    private let service: ServiceRepresentable

    // MARK: Initailizers
    
    init(service: ServiceRepresentable = Service.shared) {
        self.service = service
    }
    
    // MARK: Exposed method(s)
    
    func setViewDelegate(delegate: HomePresenterDelegate) {
        self.delegate = delegate
    }
    
    func getPokemons() {
        service.sendRequestWithJSON(endpoint: Endpoints.shared.baseURL, method: .get) {[weak self] response, error in
            guard let self = self else { return }
            if error == nil {
                do {
                    let pokemonResult = try JSONDecoder().decode(PokemonResult.self, from: response as! Data)
                    self.delegate?.showPokemonList(pokemons: pokemonResult.results!)
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
    
    func getPokemonInfo(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void) {
        service.sendRequestWithJSON(endpoint: pokemon.url!, method: .get) { response, error in
            if error == nil {
                do {
                    if let data = response as? Data{
                        let sprite = try JSONDecoder().decode(Sprite.self, from: data)
                        if let frontValue = sprite.sprites?.front_default,
                           let url = URL(string: frontValue) {
                            URLSession.shared.dataTask(with: url) { data, response, error in
                                guard let imageData = data else { return }
                                completion(UIImage(data: imageData))
                            }.resume()
                        }
                        else{
                            completion(nil)
                        }
                    }
                    else {
                        completion(nil)
                    }
                }
                catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
