//
//  MockInternet.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 15/09/22.
//

import Foundation
@testable import PokeDemo

class MockInternet {
    
    var internet: InternetManager
    var isInternetAvailable = true
    
    init(internet: InternetManager = Internet()) {
        self.internet = internet
    }
}
