//
//  CardTableViewController.swift
//  Cards CR Hiberus
//
//  Created by Augusto C.P. on 10/28/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit
import RxSwift

class CardTableViewController: UITableViewController {

    let cardVM = CardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func table(items data : [CardModel] ){
        
        let items = Observable.just(data)
//
//        items.bind(to: tableView.rx.items(cellIdentifier: "settingFollowUsCell", cellType: UITableViewCell.self)) { row, model, cell in
//            cell.nameLabel?.text = model.name
//            cell.iconImageView.image = model.icon
//            cell.selectionStyle = .none
//            }.disposed(by: disposbag)
        
        
//        tableView.rx
//            .modelSelected(ItemFollowModel.self)
//            .subscribe(onNext: { value in
//
//                self.showRRSS(item: value)
//            })
//            .disposed(by: disposbag)
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

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
