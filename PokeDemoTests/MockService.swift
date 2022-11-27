//
//  MockService.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 15/09/22.
//

import Foundation
import Alamofire
@testable import PokeDemo

final class MockService: ServiceRepresentable {
    
    var sendRequestWithJSONIsCalledIndex = 0
    var sendRequestWithJSONEndPoint: String = ""
    var onCompletion: (( _ response: Any?, _ error: Error?) -> Void)?
    func sendRequestWithJSON(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String:Any]? = nil,
        header: String? = nil,
        _ onCompletion: @escaping ( _ response: Any?, _ error: Error?) -> Void
    ){
        sendRequestWithJSONIsCalledIndex += 1
        sendRequestWithJSONEndPoint = endpoint
        self.onCompletion = onCompletion
    }
    
    func loadJson(fileName: String) -> [Pokemon]? {
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let pokemons = try? JSONDecoder().decode(PokemonResult.self, from: data)
                
        else {
            return nil
        }
        return pokemons.results
    }
}
