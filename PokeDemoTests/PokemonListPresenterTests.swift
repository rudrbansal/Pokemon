//
//  PokeDemoTests.swift
//  PokeDemoTests
//
//  Created by Rudr Bansal on 06/08/22.
//

import XCTest
@testable import PokeDemo
import Alamofire

final class PokemonListPresenterTests: XCTestCase {
    
    var presenter: PokemonListPresenter!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        presenter = PokemonListPresenter(service: Service.shared)
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testDelegateSetsValidValue(){
        // Given
        let mockDelegate = MockPresenterDelegate()
        
        // When
        presenter.setViewDelegate(delegate: mockDelegate)
        
        // Then
        XCTAssertTrue(presenter.delegate is MockPresenterDelegate)
    }
    
    func testGetPokemonListCallsAPI(){
        // Given
        let mockService = MockService()
        
        // When
        presenter = PokemonListPresenter(service: mockService)
        presenter.viewDidLoad()
        
        // Then
        XCTAssertEqual(mockService.sendRequestWithJSONIsCalledIndex, 1)
        XCTAssertEqual(mockService.sendRequestWithJSONEndPoint, "https://pokeapi.co/api/v2/pokemon")
    }
    
    func testGetPokemonListReturnsSuccessFromAPI(){
        // Given
        let mockService = MockService()
        let mockDelegate = MockPresenterDelegate()
        presenter = PokemonListPresenter(service: mockService)
        presenter.setViewDelegate(delegate: mockDelegate)
        presenter.viewDidLoad()
        
        // When service sends successful response
        let stubPokemons = [Pokemon.init(name: "test", url: "Test URL")]
//        mockService.onCompletion?(stubPokemons, nil)
        
        // Then
        XCTAssertEqual(mockDelegate.pokemons, stubPokemons)
        // Check the mockDelegate showPokemonList function is called with right Pokemon array
    }
    
    func testGetPokemonListReturnsErrorFromAPI(){
        // Given
        let mockService = MockService()
        let mockDelegate = MockPresenterDelegate()
        presenter = PokemonListPresenter(service: mockService)
        presenter.setViewDelegate(delegate: mockDelegate)
        presenter.viewDidLoad()
        
        // When service sends successful response
        mockService.onCompletion?(nil, TestError())
        
        // Then
        XCTAssertEqual(mockDelegate.showAlertCalled, true)
        XCTAssertEqual(mockDelegate.showAlertTitle, Constants.error)
        XCTAssertEqual(mockDelegate.showAlertMessage, "The operation couldn’t be completed. (PokeDemoTests.TestError error 1.)")
        // Check the mockDelegate showPokemonList function is called with right Pokemon array
    }
    
    func testGetPokemonListReturnsNoInternetFailureFromAPI(){
        // Given
        let mockService = MockService()
        let mockDelegate = MockPresenterDelegate()
        presenter = PokemonListPresenter(service: mockService)
        presenter.setViewDelegate(delegate: mockDelegate)
        presenter.viewDidLoad()
        
        // When service sends successful response
        mockService.onCompletion?(nil, TestError())
        
        // Then
        XCTAssertEqual(mockDelegate.showAlertCalled, true)
        XCTAssertEqual(mockDelegate.showAlertTitle, Constants.error)
        XCTAssertEqual(mockDelegate.showAlertMessage, Internet.shared.noInternet)
    }
    
    func testGetPokemonListReturnsInvalidDataFromAPI(){}
    
    func testGetPokemonListReturnsGeneralErrorFromAPI(){
        // Given
        let mockService = MockService()
        
        // When
        presenter = PokemonListPresenter(service: mockService)
        presenter.viewDidLoad()
        
        // Then
        XCTAssertEqual(mockService.sendRequestWithJSONIsCalledIndex, 1)
    }
}

struct TestError: Error{
    
}

final class MockPresenterDelegate: PokemonListViewPresenterDelegate {
        
    var showAlertCalled: Bool = false
    var showAlertTitle: String?
    var showAlertMessage: String?
    var pokemons: [Pokemon]?
    
    func show(_ pokemons: [Pokemon]) {
        self.pokemons = pokemons
    }
    
    func showAlert(title: String, message: String) {
        showAlertCalled = true
        showAlertTitle = title
        showAlertMessage = message
    }
}

