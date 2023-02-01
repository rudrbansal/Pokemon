//
//  PokemonListPresenter.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 15/07/22.
//

import Foundation

protocol PokemonListPresenterDelegate: AnyObject {
    func show(_ pokemons: [Pokemon])
    func showAlert(title: String, message: String)
}


final class PokemonListPresenter {
    
    private enum Constant {
        static let error = "Error"
        static let url = "https://pokeapi.co/api/v2/pokemon"
    }
    
    // MARK: Properties
    
    // MARK: Public
    
    weak var delegate: PokemonListPresenterDelegate?
    
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
    
    func didSetupCellWith(pokemon: Pokemon, completion: @escaping (Data?) -> Void) {
        service.sendRequestWithJSON(endpoint: pokemon.url, method: .get) { responseData, error in
            guard error == nil else { return completion(nil) }
            
            guard let data = responseData else { return completion(nil) }
            
            let attributes = try? JSONDecoder().decode(PokemonAttributes.self, from: data)
            guard let frontValue = attributes?.attributes.frontImage else { return completion(nil) }
            
            self.service.sendRequestWithJSON(endpoint: frontValue, method: .get) { responseData, error in
                guard let imageData = responseData else { return completion(nil) }
                completion(imageData)
            }
        }
    }
    
    // MARK: Private method(s)
    
    private func getPokemons() {
        
        func showError(error: Error?) {
            delegate?.showAlert(
                title: Constant.error,
                message: error?.localizedDescription ?? "Sorry, something went wrong"
            )
        }
        
        service.sendRequestWithJSON(endpoint: Constant.url, method: .get) { [weak self] responseData, error in
            guard let self = self else { return }
            
            guard error == nil else { return showError(error: error) }
            
            guard let pokemonResponse = responseData else { return showError(error: nil) }
            
            guard let pokemonResult = try? JSONDecoder().decode(
                PokemonResult.self,
                from: pokemonResponse
            ) else { return showError(error: nil) }
            
            self.delegate?.show(pokemonResult.results)
        }
    }
}
