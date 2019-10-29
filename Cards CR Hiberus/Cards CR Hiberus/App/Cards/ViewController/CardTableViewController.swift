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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Cards"
        self.navigationItem.setHidesBackButton(true, animated:true);

        cardVM.callCardsObservable  { result in
            switch result{
            case .success(let model):
                self.cardVM.cards = model
                self.tableView.reloadData()
                break
                
            case .failure(let errorT):
                print(errorT.get().message)
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
        return self.cardVM.cards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)

        cell.textLabel?.text = self.cardVM.cards[indexPath.row].name
        cell.detailTextLabel?.text = self.cardVM.cards[indexPath.row].type
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = R.storyboard.card.cardDetailViewController() {
            vc.data = self.cardVM.cards[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
