//
//  ViewController.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//
// MARK: - Navigation

import UIKit

class PokemonListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: PokemonListCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PokemonListCell.reuseIdentifier)
            tableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    
    // MARK: - Private
    
    private let presenter = PokemonListPresenter()
    private var pokemons: [Pokemon]? = [Pokemon]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.viewDidLoad()
    }
}

// MARK: - Extensions

extension PokemonListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListCell.reuseIdentifier) as? PokemonListCell else { return UITableViewCell() }
        guard let pokemons else { return PokemonListCell() }
        let pokemon = pokemons[indexPath.row]
        cell.setupData(data: pokemon)
        presenter.didSetupCellWith(pokemon: pokemon) { image in
            if let image = image{
                DispatchQueue.main.async {
                    cell.setupImage(image: image)
                }
            }
        }
        return cell
    }
}

extension PokemonListViewController: PokemonListPresenterDelegate {
    
    func show(_ pokemons: [Pokemon]) {
        self.pokemons?.append(contentsOf: pokemons)
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        AlertUtility.shared.showAlert(self, title: title, message: message)
    }
}
