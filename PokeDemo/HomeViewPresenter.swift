//
//  HomeViewPresenter.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 15/07/22.
//

import Foundation
import UIKit

protocol HomeViewPresenterDelegate: AnyObject {
    func showPokemonList(pokemon: [Pokemon])
    func showAlert(title: String, message: String)
}

typealias PresenterDelegate = HomeViewPresenterDelegate & UIViewController

class HomeViewPresenter {
    
    weak var delegate: PresenterDelegate?
    var imageURL: String?
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getPokemonList() {
        Service.shared.sendRequestWithJSON(endpoint: Endpoints.shared.baseURL, method: .get) {[weak self] response, error in
            guard let strongSelf = self else { return }
            if error == nil {
                do {
                    let pokemons = try JSONDecoder().decode(PokemonResult.self, from: response as! Data)
                    strongSelf.delegate?.showPokemonList(pokemon: pokemons.results!)
                }
                catch {
                    print("Decoding error is \(error)")
                    strongSelf.delegate?.showAlert(title: AlertUtility.AlertTitles.error, message: error.localizedDescription)
                }
            } else {
                strongSelf.delegate?.showAlert(title: AlertUtility.AlertTitles.error, message: error?.localizedDescription ?? AlertUtility.AlertTitles.error)
            }
        }
    }
}
