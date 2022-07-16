//
//  PokemonViewModel.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import Foundation
import Alamofire

class PokemonViewModel {
    
    var pokemonList: [Pokemon]? = [Pokemon]()
    var count: Int?
    var limit: Int?
    var offset: Int?
    
    func getPokemonList(_ onCompletion: @escaping ( _ success: Bool?, _ error: Error?) -> Void) {
        Service.shared.sendRequestWithJSON(endpoint: Endpoints.shared.baseURL, method: .get) {[weak self] response, error in
            guard let strongSelf = self else { return }
            if error == nil {
                do {
                    let pokemons = try JSONDecoder().decode(PokemonResult.self, from: response as! Data)
                    strongSelf.pokemonList?.append(contentsOf: pokemons.results!)
                    strongSelf.count = pokemons.count
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
