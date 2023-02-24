//
//  PokemonDetailPresenterTests.swift
//  PokeDemoTests
//
//  Created by Rudr Bansal on 19/02/23.
//

import XCTest
@testable import PokeDemo

final class PokemonDetailPresenterTests: XCTestCase {
    
    private(set) var presenter: PokemonDetailPresenter?
    private let mockService = MockService()
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        presenter = PokemonDetailPresenter(service: mockService)
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testDelegateSetsValidValue(){
        // Given
        let mockDelegate = MockPokemonDetailViewPresenterDelegate()
        
        // When
        presenter?.delegate = mockDelegate
        
        // Then
        XCTAssertTrue(presenter?.delegate is MockPokemonDetailViewPresenterDelegate)
    }

}

final class MockPokemonDetailViewPresenterDelegate: PokemonDetailPresenterDelegate {

    private(set) var showAlertCalledCount: Int = 0
    private(set) var showAlertTitle: String?
    private(set) var showAlertMessage: String?
    
    func showPokemonDetail(pokemon: PokeDemo.PokemonAttributes) {
        
    }
    
    func updateimage(image: UIImage) {
        
    }
    
    func showAlert(title: String, message: String) {
        
    }
}
