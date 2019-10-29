//
//  UserInfoViewController.swift
//  Cards CR Hiberus
//
//  Created by Augusto C.P. on 10/28/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var middleTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var doneBaritemButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }
    
    func configUI() {
        
        self.nameTextField.delegate = self
        self.nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.middleTextField.delegate = self
        self.middleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.lastnameTextField.delegate = self
        self.lastnameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.emailTextField.delegate = self
        self.emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func validAllFields() -> Bool {
        return self.nameTextField.isValid() && self.middleTextField.isValid() && self.lastnameTextField.isValid() && self.emailTextField.isValidEmail()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField != self.emailTextField  {
            return string.rangeOfCharacter(from: NSCharacterSet.letters) != nil
        }else {
            return true
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        print("type..")
        self.doneBaritemButton.isEnabled = self.validAllFields()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.validAllFields() {
            
        }
        
        return false
    }
    
}
