//
//  string+extension.swift
//  Cards CR Hiberus
//
//  Created by Augusto C.P. on 10/29/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation

extension String {
    
    func isEmail() -> Bool {
        
        let  emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}
