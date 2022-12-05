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
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    // MARK: - Private

    private let presenter = HomeViewPresenter()
    private var pokemons: [Pokemon]? = [Pokemon]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: PokemonListCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: PokemonListCell.cellIdentifier())
        presenter.setViewDelegate(delegate: self)
        presenter.getPokemons()
    }
}

// MARK: - Extensions

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListCell.cellIdentifier()) as! PokemonListCell
        let pokemon = pokemons![indexPath.row]
        cell.setupData(data: pokemon)
        presenter.getPokemonInfo(pokemon: pokemon) { image in
            if let image = image{
                DispatchQueue.main.async {
                    cell.setupImage(image: image)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController: PokemonDetailViewController = moveToViewController(storyboard: "Main", destination: PokemonDetailViewController.identifier()) as! PokemonDetailViewController
        detailViewController.pokemon = (pokemons?[indexPath.row])
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension PokemonListViewController: HomeViewPresenterDelegate {
    
    func showPokemonList(pokemons: [Pokemon]) {
        self.pokemons?.append(contentsOf: pokemons)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        AlertUtility.shared.showAlert(self, title: title, message: message)
    }
}
