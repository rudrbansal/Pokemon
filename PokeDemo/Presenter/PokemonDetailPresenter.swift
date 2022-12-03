//
//  PokemonDetailPresenter.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 30/11/22.
//

import UIKit
import Foundation

protocol PokemonDetailViewPresenterDelegate: AnyObject {
    func showPokemonDetail(pokemon: SpriteDetail)
    func showAlert(title: String, message: String)
}

typealias PokemonDetailPresenterDelegate = PokemonDetailViewPresenterDelegate & UIViewController

final class PokemonDetailPresenter {
    
    // MARK: Properties
    
    // MARK: Public
    
    weak var delegate: PokemonDetailPresenterDelegate?
    
    // MARK: Private
    
    private let service: ServiceRepresentable
    private let errorTitle = "Error"
    
    // MARK: Initailizers
    
    init(service: ServiceRepresentable = Service.shared) {
        self.service = service
    }
    
    // MARK: Exposed method(s)
    
    func setViewDelegate(delegate: PokemonDetailPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getPokemonDetail(name: String) {
        Service.shared.sendRequestWithJSON(endpoint: (Endpoints.shared.baseURL + "/" + name + "/"), method: .get) {[weak self] response, error in
            guard let self = self else { return }
            if error == nil {
                do {
                    let sprite = try JSONDecoder().decode(Sprite.self, from: response as! Data)
                    self.delegate?.showPokemonDetail(pokemon: sprite.sprites!)
                }
                catch {
                    self.delegate?.showAlert(title: self.errorTitle, message: error.localizedDescription)
                }
            } else {
                self.delegate?.showAlert(title: self.errorTitle, message: error!.localizedDescription)
            }
        }
    }
}
