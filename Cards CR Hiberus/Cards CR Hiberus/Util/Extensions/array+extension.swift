//
//  array+extension.swift
//  Cards CR Hiberus
//
//  Created by Augusto C.P. on 10/30/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation

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
