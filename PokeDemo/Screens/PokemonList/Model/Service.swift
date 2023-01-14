//
//  Service.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//

import Foundation
import Alamofire

protocol ServiceRepresentable {
    func sendRequestWithJSON(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String:Any]?,
        header: String?,
        _ onCompletion: @escaping ( _ responseData: Data?, _ error: Error?) -> Void
    )
}

extension ServiceRepresentable {
    func sendRequestWithJSON(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String:Any]? = nil,
        header: String? = nil,
        _ onCompletion: @escaping ( _ responseData: Data?, _ error: Error?) -> Void
    ){
        self.sendRequestWithJSON(endpoint: endpoint, method: method, parameters: parameters, header: header, onCompletion)
    }
}

final class Service: ServiceRepresentable {
    // MARK: - Singleton
    
    static let shared = Service()
    
    // MARK: - Exposed Methods
    
    func sendRequestWithJSON(endpoint: String, method: HTTPMethod, parameters: [String:Any]? = nil, header: String? = nil, _ onCompletion: @escaping ( _ responseData: Data?, _ error: Error?) -> Void) {
        AF.request(endpoint, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responseHandler in
            guard let data = responseHandler.data else {
                onCompletion(nil, responseHandler.error)
                return
            }
            onCompletion(data, responseHandler.error)
        }
    }
}
