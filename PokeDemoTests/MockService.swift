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
    var onCompletion: (( _ responseData: Data?, _ error: Error?) -> Void)?
    
    func sendRequestWithJSON(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String:Any]? = nil,
        header: String? = nil,
        _ onCompletion: @escaping ( _ responseData: Data?, _ error: Error?) -> Void
    ){
        sendRequestWithJSONIsCalledIndex += 1
        sendRequestWithJSONEndPoint = endpoint
        self.onCompletion = onCompletion
    }
}
