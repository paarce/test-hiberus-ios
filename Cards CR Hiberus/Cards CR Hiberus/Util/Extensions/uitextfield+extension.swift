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
        
        return self.text != nil ? self.text!.isEmail() : false
    }
    
    
    func isWithinLength(max: Int = 16, range: NSRange, string: String) -> Bool {
        
        let currentText = self.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= max
    }
}
