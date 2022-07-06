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
    
    private let pokemonViewModel = PokemonViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonList()
    }
    
    // MARK: - API methods
    
    private func getPokemonList() {
        pokemonViewModel.getPokemonList {[weak self] success, error in
            guard let strongSelf = self else { return }
            if success ?? false {
                strongSelf.pokemonTableView.dataSource = strongSelf
                strongSelf.pokemonTableView.delegate = strongSelf
                strongSelf.pokemonTableView.reloadData()
            } else {
                AlertUtility.showAlert(strongSelf, title: AlertUtility.AlertTitles.error, message: error?.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonViewModel.pokemonList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.cellIdentifier()) as! PokemonTableViewCell
        cell.setupData(data: pokemonViewModel.pokemonList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController: PokemonDetailViewController = CommonUtilities.moveToViewController(storyboard: Constants.Storyboards.main.rawValue, destination: Constants.ViewControllers.pokemonDetail.rawValue) as! PokemonDetailViewController
        detailViewController.pokemonName = (pokemonViewModel.pokemonList![indexPath.row].name ?? "")
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
