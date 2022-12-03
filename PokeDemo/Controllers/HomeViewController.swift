//
//  ViewController.swift
//  PokeDemo
//
//  Created by Rudr Bansal on 05/07/22.
//
// MARK: - Navigation

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    // MARK: - Properties
    
    // MARK: - Private

    private let presenter = HomeViewPresenter(service: Service.shared)
    private var pokemonList: [Pokemon]? = [Pokemon]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.getPokemonList()
    }
}

// MARK: - Extensions

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.cellIdentifier()) as! PokemonTableViewCell
        let pokemon = pokemonList![indexPath.row]
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
        let detailViewController: PokemonDetailViewController = CommonUtilities.moveToViewController(storyboard: "Main", destination: PokemonDetailViewController.identifier()) as! PokemonDetailViewController
        detailViewController.pokemonName = (pokemonList![indexPath.row].name ?? "")
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            if presenter.isLoadingCell(for: indexPath) {
                self.pokemonTableView.tableFooterView = spinner
                self.pokemonTableView.tableFooterView?.isHidden = false
                presenter.getPokemonList()
            } else {
                self.pokemonTableView.tableFooterView?.isHidden = true
            }
        }
    }
}

extension HomeViewController: HomeViewPresenterDelegate {
    
    func showPokemonList(pokemons: [Pokemon]) {
        pokemonList?.append(contentsOf: pokemons)
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        pokemonTableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        AlertUtility.shared.showAlert(self, title: title, message: message)
    }
}
