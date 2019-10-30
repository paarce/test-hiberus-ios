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
                self.tableView.reloadData()
                
                DispatchQueue.main.async {
                    
                    if var types = (self.cardVM.cards.map { $0.type }).uniques as? [String] {
                        types.insert("All types", at: 0)
                        self.cardVM.cardsTypes = types
                        self.searchController.searchBar.scopeButtonTitles = self.cardVM.cardsTypes
                    }
                }

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
        searchController.searchBar.placeholder = "Search Cards"
        navigationItem.searchController = searchController
        
        self.searchController.searchBar.scopeButtonTitles = ["All types"]
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        self.cardVM.currentIndexType = selectedScope
        let searcBar = searchController.searchBar
        
        if let q = searcBar.text {
            self.cardVM.filterList(q: q)
            self.tableView.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searcBar = searchController.searchBar
        
        if let q = searcBar.text {
            
            self.cardVM.filterList(q: q)
            self.tableView.reloadData()
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

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
