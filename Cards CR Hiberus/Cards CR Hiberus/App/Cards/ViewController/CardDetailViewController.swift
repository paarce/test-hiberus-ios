//
//  CardDetailViewController.swift
//  Cards CR Hiberus
//
//  Created by Augusto C.P. on 10/29/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit
import Kingfisher

class CardDetailViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var data : CardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadUI()
        
    }
    
    /// Method to load the data to UI
    func loadUI() {
        
        if let data = self.data {
            
            if let url = data.getImageUrl() {
                self.iconImageView.kf.indicatorType = .activity
                self.iconImageView.kf.setImage(with: url)
            }
            
            self.nameLabel.text = data.name ?? "No name"
            self.descriptionLabel.text = data.description ?? "No description"
        }
    }
    
}
