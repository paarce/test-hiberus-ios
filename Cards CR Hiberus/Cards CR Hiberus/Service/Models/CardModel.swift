//
//  CardModel.swift
//  Cards CR Hiberus
//
//  Created by Augusto C.P. on 10/28/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation

struct CardModel : Codable {

    let _id : String?
    let idName : String?
    let rarity : String?
    let type : String?
    let name : String?
    let description : String?
    let elixirCost : Int?
    let copyId : Int?
    let arena : Int?
    let order : Int?
    
    func getImageUrl() -> URL? {
        if let imageName = self.idName {
            return URL(string: "http://www.clashapi.xyz/images/cards/\(imageName).png")
        }
        return nil
    }
}
