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

final class HomeViewPresenter {
    
    // MARK: Properties
    
    // MARK: Public
    
    weak var delegate: PresenterDelegate?
    
    // MARK: Private
    
    private let service: ServiceRepresentable
    
    // MARK: Initailizers
    
    init(service: ServiceRepresentable = Service.shared) {
        self.service = service
    }
    
    // MARK: Exposed method(s)
    
    func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func getPokemonList() {
        service.sendRequestWithJSON(endpoint: Endpoints.shared.baseURL, method: .get) {[weak self] response, error in
            guard let strongSelf = self else { return }
            if error == nil {
                do {
                    let pokemons = try JSONDecoder().decode(PokemonResult.self, from: response as! Data)
                    strongSelf.delegate?.showPokemonList(pokemon: pokemons.results!)
                }
                catch {
                    print("Decoding error is \(error)")
                    // Show alert that something is wrong with server
                    strongSelf.delegate?.showAlert(title: AlertUtility.AlertTitles.error, message: error.localizedDescription)
                }
            } else if !Internet.shared.isAvailable() {
                strongSelf.delegate?.showAlert(title: AlertUtility.AlertTitles.error, message: AlertUtility.AlertMessages.noInternet)
            } else {
                // if error is network error - Show no internet connection alert
                // else: Show general error alert
                strongSelf.delegate?.showAlert(title: AlertUtility.AlertTitles.error, message: error?.localizedDescription ?? AlertUtility.AlertMessages.somethingWrong)
            }
        }
    }
}
