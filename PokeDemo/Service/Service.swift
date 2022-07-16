//
//  Service.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import Foundation
import Alamofire

class Service {
    
    static let shared = Service()
    
    func sendRequestWithJSON(endpoint: String, method: HTTPMethod, parameters: [String:Any]? = nil, header: String? = nil, _ onCompletion: @escaping ( _ response: Any?, _ error: Error?) -> Void) {
        if Internet.isAvailable() {
            AF.request(endpoint, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responseHandler in
                guard let data = responseHandler.data else { return }
                onCompletion(data, responseHandler.error)
            }
        } else {
//            TODO: handle error crash
            onCompletion(nil, AlertUtility.AlertMessages.noInternet as? Error)
        }
    }
}
