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
    
    private(set) var sendRequestWithJSONIsCalledCount = 0
    private(set) var sendRequestWithJSONEndPoint: String = ""
    private(set) var onCompletion: (( _ responseData: Data?, _ error: Error?) -> Void)?
    
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
