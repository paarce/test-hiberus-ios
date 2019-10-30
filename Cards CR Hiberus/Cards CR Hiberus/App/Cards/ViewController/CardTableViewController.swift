//
//  CardTableViewController.swift
//  Cards CR Hiberus
//
//  Created by Augusto C.P. on 10/28/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CardTableViewController: UITableViewController {

    let cardVM = CardViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Cards"
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        self.loadUI()
        self.configSearchBar()

    }
    
    func loadUI() {
        
        cardVM.callCardsObservable  { result in
            switch result{
            case .success(let model):
                self.cardVM.cards = model
                print(self.cardVM.cardsFilter.count)
                self.tableView.reloadData()
                break
                
            case .failure(let errorT):
                
                let dialogMessage = UIAlertController(title: "Error", message: errorT.get().message ?? "Somthing went wrong", preferredStyle: .alert)
                
                dialogMessage.addAction( UIAlertAction(title: "Try Again", style: .cancel) { (action) -> Void in
                    self.loadUI()
                })
                
                self.present(dialogMessage, animated: true, completion: nil)
                
                //print(errorT.get().message)
                break
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cardVM.cardsFilter.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)

        cell.textLabel?.text = self.cardVM.cardsFilter[indexPath.row].name
        cell.detailTextLabel?.text = self.cardVM.cardsFilter[indexPath.row].type
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = R.storyboard.card.cardDetailViewController() {
            vc.data = self.cardVM.cardsFilter[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}


extension CardTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func configSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Restaurants"
        navigationItem.searchController = searchController
        
        //searchController.searchBar.scopeButtonTitles = ["All type"]
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(selectedScope)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searcBar = searchController.searchBar
        
        if let q = searcBar.text {
            
            if !q.isEmpty {
                self.cardVM.cardsFilter = self.cardVM.cards.filter { model -> Bool in
                    return model.name?.lowercased().contains(q.lowercased()) ?? false
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searcBar = searchController.searchBar
        print(searcBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.cardVM.cardsFilter = self.cardVM.cards
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searchBarCancelButtonClicked(searchBar)
        }
    }
    
}
