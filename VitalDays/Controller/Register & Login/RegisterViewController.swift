//
//  RegisterViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 3/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController{
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confimPasswordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomization()
    }
    
    fileprivate func setupCustomization(){
        registerBtn.clipsToBounds = true
        registerBtn.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        registerBtn.layer.cornerRadius = 20
        
        continueBtn.clipsToBounds = true
        continueBtn.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        continueBtn.layer.cornerRadius = 20
        
        signInBtn.clipsToBounds = true
        signInBtn.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        signInBtn.layer.cornerRadius = 20
        
        emailTextField.textColor = .white
        passwordTextField.textColor = .white
        passwordTextField.isSecureTextEntry = true
        confimPasswordTextField.textColor = .white
        confimPasswordTextField.isSecureTextEntry = true
        nameTextField.textColor = .white
    }
    
    /// handle the close button pressed
    @IBAction func closeBtnPressed(_ sender: Any) {
        print("close btn pressed!")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        print("continue btn pressed!")
        
        self.view.window?.rootViewController = ContainerViewController()
        self.view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        self.view.window?.rootViewController = LoginViewController()
        self.view.window?.makeKeyAndVisible()
    }
    
    /// handle register button pressed
    @IBAction func registerBtnPressed(_ sender: Any) {
        print("register btn pressed!")
        // validate textfileds
        guard validateTextFields() else { return }
        // register account
        Auth.auth().createUser(withEmail: emailTextField.text!,
                               password: confimPasswordTextField.text!) { [weak self] (result, error) in
                                guard let weakSelf = self else{return}
                                if error != nil {
                                    Utils.shard.showError("Register account getting error: \(String(describing: error))", weakSelf)
                                }
                                
                                print("register successfully!")
                                
                                // save the user info
                                if result != nil{
                                    let ref = Database.database().reference()
                                    ref.child("Users").child(result!.user.uid).setValue(["email": self!.emailTextField.text!,
                                                                                         "name": self!.nameTextField.text!])
                                    let mainVC = ContainerViewController()
                                    self?.view.window?.rootViewController = mainVC
                                    self?.view.window?.makeKeyAndVisible()
                                }else{
                                    print("saving user data with errors")
                                }
        }
    }
    
    /// check if all the textfields are filled out and whether the passwords are the same and satisfy the criteria
    fileprivate func validateTextFields() -> Bool{
        if emailTextField.text == "" ||
        passwordTextField.text == "" ||
        confimPasswordTextField.text == "" ||
            nameTextField.text == ""{
            print("please enter details first!")
            Utils.shard.showError("please enter all the details first", self)
            return false
        }
        
        if passwordTextField.text != confimPasswordTextField.text {
            print("confirmed password is not the same")
            Utils.shard.showError("passwords are not the same", self)
            return false
        }
        
        guard validatePassword() else { return false }
        
        return true
    }
    
    /// validate the password
    fileprivate func validatePassword() -> Bool{
        guard NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$").evaluate(with: passwordTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces)) else{
            Utils.shard.showError("Password should contain minimum 8 characters at least 1 alphabet and 1 number", self)
            print("password does't satisfy the criteria")
            return false
        }
        print("finished validating")
        
        return true
    }
}
