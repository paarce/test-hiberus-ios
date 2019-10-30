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

    func callCardsObservable(completation: @escaping (Result<[CardModel],ErrorApi>) -> Void) {
        
        Api.request(endpoint : .cards, completation : completation)
    }


}
