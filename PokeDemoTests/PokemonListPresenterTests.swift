//
//  PokeDemoTests.swift
//  PokeDemoTests
//
//  Created by Rudr Bansal on 06/08/22.
//

import XCTest
@testable import PokeDemo

final class PokemonListPresenterTests: XCTestCase {
    
    var presenter: PokemonListPresenter!
    let mockService = MockService()
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        presenter = PokemonListPresenter(service: mockService)
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testDelegateSetsValidValue(){
        // Given
        let mockDelegate = MockPokemonListViewPresenterDelegate()
        
        // When
        presenter.delegate = mockDelegate
        
        // Then
        XCTAssertTrue(presenter.delegate is MockPokemonListViewPresenterDelegate)
    }
    
    func testGetPokemonListCallsAPI(){
        // Given
        
        // When
        presenter = PokemonListPresenter(service: mockService)
        presenter.viewDidLoad()
        
        // Then
        XCTAssertEqual(mockService.sendRequestWithJSONIsCalledIndex, 1)
        XCTAssertEqual(mockService.sendRequestWithJSONEndPoint, "https://pokeapi.co/api/v2/pokemon")
    }
    
    func testGetPokemonListReturnsSuccess(){
        // Given
        let mockDelegate = MockPokemonListViewPresenterDelegate()
        presenter = PokemonListPresenter(service: mockService)
        presenter.delegate = mockDelegate
        presenter.viewDidLoad()
        
        // When service sends successful response
        
        let jsonData = JSONString.success.data(using: .utf8)
        mockService.onCompletion?(jsonData, nil)
        
        // Then
        XCTAssertEqual(mockService.sendRequestWithJSONIsCalledIndex, 1)
        XCTAssertEqual(mockDelegate.pokemons?.first?.name, "test")
        XCTAssertEqual(mockDelegate.pokemons?.first?.url, "testURL")
    }
    
    func testGetPokemonListReturnsError(){
        // Given
        let mockDelegate = MockPokemonListViewPresenterDelegate()
        presenter = PokemonListPresenter(service: mockService)
        presenter.delegate = mockDelegate
        presenter.viewDidLoad()
        
        // When service sends error
        mockService.onCompletion?(nil, TestError())
        
        // Then
        XCTAssertEqual(mockService.sendRequestWithJSONIsCalledIndex, 1)
        XCTAssertEqual(mockDelegate.showAlertCalled, true)
        XCTAssertEqual(mockDelegate.showAlertTitle, Constants.error)
        XCTAssertEqual(mockDelegate.showAlertMessage, "The operation couldn’t be completed. (PokeDemoTests.TestError error 1.)")
    }
    
    func testGetPokemonListReturnsEmptyArray() {
        // Given
        let mockDelegate = MockPokemonListViewPresenterDelegate()
        presenter.delegate = mockDelegate
        presenter.viewDidLoad()
        
        // When service sends empty array in response
        let jsonData = JSONString.successWithEmptyArray.data(using: .utf8)
        mockService.onCompletion?(jsonData, nil)
        
        // Then
        XCTAssertEqual(mockService.sendRequestWithJSONIsCalledIndex, 1)
        XCTAssertEqual(mockDelegate.pokemons?.count, 0)
    }
}

private extension PokemonListPresenterTests {
    enum JSONString {
        static let success = """
        {
            "count": 1279,
            "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            "previous": null,
            "results": [{
                "name": "test",
                "url": "testURL"
            }]
        }
        """
        static let successWithEmptyArray = """
        {
            "count": 1279,
            "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            "previous": null,
            "results": []
        }
        """
    }
}

struct TestError: Error{
    
}

final class MockPokemonListViewPresenterDelegate: PokemonListPresenterDelegate {
    
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
