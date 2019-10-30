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
        
        
        if let name = defaults.string(forKey: "user_name"), let middle = defaults.string(forKey: "user_middle"), let lastname = defaults.string(forKey: "user_lastname"), let email = defaults.string(forKey: "user_email") {
            
            let dialogMessage = UIAlertController(title: "Already Logged", message: "Are you \(name)? Do you want to continue in this session?", preferredStyle: .alert)
            
            dialogMessage.addAction( UIAlertAction(title: "No", style: .cancel) { (action) -> Void in
                self.cleanAllFields()
            })
            
            dialogMessage.addAction( UIAlertAction(title: "Continue", style: .default) { (action) -> Void in
                
                if let vc = R.storyboard.card.instantiateInitialViewController() {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
            self.present(dialogMessage, animated: true, completion: nil)
            
            self.nameTextField.text = name
            self.middleTextField.text = middle
            self.lastnameTextField.text = lastname
            self.emailTextField.text = email
            
        }
        
    }
    
    func cleanAllFields() {
        
        self.nameTextField.text = ""
        self.middleTextField.text = ""
        self.lastnameTextField.text = ""
        self.emailTextField.text = ""
    }
    
    func validAllFields() -> Bool {
        return self.nameTextField.isValid() && self.middleTextField.isValid() && self.lastnameTextField.isValid() && self.emailTextField.isValidEmail()
    }
    
    @IBAction func onDone(_ sender: Any) {
        if self.validAllFields() {
            
            defaults.set(self.nameTextField.text!, forKey: "user_name")
            defaults.set(self.middleTextField.text!, forKey: "user_middle")
            defaults.set(self.lastnameTextField.text!, forKey: "user_lastname")
            defaults.set(self.emailTextField.text!, forKey: "user_email")
            defaults.synchronize()
            
            if let vc = R.storyboard.card.instantiateInitialViewController() {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField != self.emailTextField  {
            return string.rangeOfCharacter(from: NSCharacterSet.letters) != nil || string.isEmpty
        }else {
            return true
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        self.doneBaritemButton.isEnabled = self.validAllFields()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.onDone(textField)
        
        return false
    }
    
}
