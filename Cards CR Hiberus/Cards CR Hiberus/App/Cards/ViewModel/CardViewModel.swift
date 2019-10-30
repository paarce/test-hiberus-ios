//
//  CardViewModel.swift
//  Cards CR Hiberus
//
//  Created by Augusto C.P. on 10/28/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation

class CardViewModel {
    
    var cards : [CardModel] = [] {
        didSet{
            self.cardsFilter = self.cards
        }
    }
    var cardsFilter : [CardModel] = []
    var cardsTypes : [String] = []
    var currentIndexType = 0

    func callCardsObservable(completation: @escaping (Result<[CardModel],ErrorApi>) -> Void) {
        
        Api.request(endpoint : .cards, completation : completation)
    }

    func filterList(q : String) {
        
        self.cardsFilter = self.cards.filter { model -> Bool in
            return (q.isEmpty || model.name?.lowercased().contains(q.lowercased()) ?? false) &&
                   (self.currentIndexType == 0 || (self.cardsTypes[currentIndexType] == model.type) )
        }
        
    }

}
