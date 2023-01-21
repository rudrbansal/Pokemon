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
    
    var sendRequestWithJSONIsCalledCount = 0
    var sendRequestWithJSONEndPoint: String = ""
    var onCompletion: (( _ responseData: Data?, _ error: Error?) -> Void)?
    
    func sendRequestWithJSON(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String:String]? = nil,
        header: String? = nil,
        _ onCompletion: @escaping ( _ responseData: Data?, _ error: Error?) -> Void
    ){
        sendRequestWithJSONIsCalledCount += 1
        sendRequestWithJSONEndPoint = endpoint
        self.onCompletion = onCompletion
    }
}
