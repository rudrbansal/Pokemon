//
//  ViewController.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//
// MARK: - Navigation

import UIKit

class ViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    // MARK: - Properties
    
//    private let pokemonViewModel = PokemonViewModel()
    private let presenter = HomeViewPresenter()
    private var pokemonList: [Pokemon]? = [Pokemon]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.getPokemonList()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.cellIdentifier()) as! PokemonTableViewCell
        cell.setupData(data: pokemonList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController: PokemonDetailViewController = CommonUtilities.moveToViewController(storyboard: Constants.Storyboards.main.rawValue, destination: Constants.ViewControllers.pokemonDetail.rawValue) as! PokemonDetailViewController
        detailViewController.pokemonName = (pokemonList![indexPath.row].name ?? "")
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: HomeViewPresenterDelegate {
    
    func showPokemonList(pokemon: [Pokemon]) {
        pokemonList = pokemon
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        pokemonTableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        AlertUtility.showAlert(self, title: title, message: message)
    }
}

