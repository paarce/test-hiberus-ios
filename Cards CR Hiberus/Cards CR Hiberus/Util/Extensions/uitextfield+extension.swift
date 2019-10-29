//
//  uitextfield+extension.swift
//  Cards CR Hiberus
//
//  Created by Augusto C.P. on 10/28/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func isValid() -> Bool {
        
        return self.text != nil
    }
    
    func isValidEmail() -> Bool {
        
        if let _ = self.text {
            
            let  emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return emailTest.evaluate(with: self.text!)
        }
        return false
        
    }
    
}
