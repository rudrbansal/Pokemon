//
//  PokemonDetailViewModel.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import Foundation
import Alamofire

class PokemonDetailViewModel {
        
    var imageURL: String?
    
    func getPokemonDetail(pokemonName: String, _ onCompletion: @escaping ( _ success: Bool?, _ error: Error?) -> Void) {
        Service.shared.sendRequestWithJSON(endpoint: (Endpoints.shared.baseURL + pokemonName), method: .get) {[weak self] response, error in
            guard let strongSelf = self else { return }
            if error == nil {
                do {
                    let sprite = try JSONDecoder().decode(Sprite.self, from: response as! Data)
                    strongSelf.imageURL = sprite.sprites?.front_default
                    onCompletion(true, error)
                }
                catch {
                    print("Decoding error is \(error)")
                    onCompletion(false, error)
                }
            } else {
                onCompletion(false, error)
            }
        }
    }
}
