//
//  PokemonDetailPresenter.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 16/02/23.
//

import Foundation
import UIKit

protocol PokemonDetailViewPresenterDelegate: AnyObject {
    func showPokemonDetail(pokemon: PokemonAttributes)
    func showAlert(title: String, message: String)
    func updateimage(image: UIImage)
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
    
    func getPokemonDetail(url: String) {
        service.sendRequestWithJSON(endpoint: url, method: .get) {[weak self] response, error in
            guard let self = self else { return }
            if error == nil {
                guard let response = response else { return }
                let attributes = try? JSONDecoder().decode(PokemonAttributes.self, from: response)
                self.delegate?.showPokemonDetail(pokemon: attributes ?? PokemonAttributes.init(name: "", id: 0, attributes: PokemonImageAttribute.init(frontImage: "")))
            } else {
                self.delegate?.showAlert(title: self.errorTitle, message: error!.localizedDescription)
            }
        }
    }
    
    func fetchPokemonImageFrom(_ url: String) {
        service.sendRequestWithJSON(endpoint: url, method: .get) {[weak self] response, error in
            guard let self = self else { return }
            if error == nil {
                guard let image = response else { return }
                self.delegate?.updateimage(image: UIImage(data: image) ?? UIImage())
            } else {
                self.delegate?.showAlert(title: self.errorTitle, message: error!.localizedDescription)
            }
        }
    }
}
