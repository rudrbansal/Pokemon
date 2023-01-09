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
        let stubPokemons = mockService.loadJson(fileName: "PokemonList")
        let pokemonResult = PokemonResult.init(count: stubPokemons?.count ?? 0, next: "", results: stubPokemons ?? [])
        let pokemonData = try? JSONEncoder().encode(pokemonResult)
        mockService.onCompletion?(pokemonData, nil)
        
        // Then
        XCTAssertEqual(mockDelegate.pokemons, stubPokemons)
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
        XCTAssertEqual(mockDelegate.showAlertCalled, true)
        XCTAssertEqual(mockDelegate.showAlertTitle, Constants.error)
        XCTAssertEqual(mockDelegate.showAlertMessage, "The operation couldn’t be completed. (PokeDemoTests.TestError error 1.)")
    }
    
    func testGetPokemonListReturnsEmptyArray() {
        // Given
        let mockDelegate = MockPokemonListViewPresenterDelegate()
        presenter = PokemonListPresenter()
        presenter.delegate = mockDelegate
        presenter.viewDidLoad()
        
        // When service sends empty array in response
        let stubPokemons: [Pokemon] = []
        let pokemonResult = PokemonResult.init(count: stubPokemons.count , next: "", results: stubPokemons)
        let pokemonData = try? JSONEncoder().encode(pokemonResult)
        mockService.onCompletion?(pokemonData, nil)
        
        // Then
        XCTAssertEqual(mockDelegate.pokemons?.count, nil)
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

extension PokemonResult: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(next, forKey: .next)
        try container.encode(previous, forKey: .previous)
        try container.encode(results, forKey: .results)
        
    }
}

extension Pokemon: Encodable, Equatable {
    
    public static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return true
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
    }
}
