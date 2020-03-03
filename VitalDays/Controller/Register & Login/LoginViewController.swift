//
//  MyAccountViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 28/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController{
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Vital Days"
        label.textColor = .white
        label.font = UIFont.init(name: "Courier", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let accountTextField: UITextField = {
       let field = UITextField()
        let img = UIImageView(image: UIImage(named: "customer"))
        field.textColor = .white
        field.placeholder = "Account"
        field.attributedPlaceholder = NSAttributedString(string: field.placeholder!, attributes: [.foregroundColor:UIColor.white])
        field.underline(color: .white)
        field.leftView = img
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let rightBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "hide")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.addTarget(self, action: #selector(showOrHide), for: .touchUpInside)
        btn.tintColor = .white
        return btn
    }()
    
    let passwordTextField: UITextField = {
       let field = UITextField()
        let img = UIImageView(image: UIImage(named: "lock"))
        field.textColor = .white
        field.placeholder = "Password"
        field.attributedPlaceholder = NSAttributedString(string: field.placeholder!, attributes: [.foregroundColor:UIColor.white])
        field.underline(color: .white)
        field.isSecureTextEntry = true
        field.rightViewMode = .always
        field.leftView = img
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let forgotBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("Forgot password?", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let registerBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("Register here", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(registerAccount), for: .touchUpInside)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let saperator: UIView = {
        let bar1 = UIView()
        bar1.backgroundColor = .white
        bar1.translatesAutoresizingMaskIntoConstraints = false
        let bar2 = UIView()
        bar2.backgroundColor = .white
        bar2.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.text = "Or login with"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        let view = UIView()
        view.addSubviews(bar1, bar2, label)
        label.centerInSuper()
        bar1.anchors(centerY: view.centerYAnchor,
                     right: label.leftAnchor,
                     rightConstant: -8,
                     widthValue: UIScreen.main.bounds.width * 0.25,
                     heightValue: 1)
        bar2.anchors(centerY: view.centerYAnchor,
                     left: label.rightAnchor,
                     leftConstant: 8,
                     widthValue: UIScreen.main.bounds.width * 0.25,
                     heightValue: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let signinBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign in", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        btn.addTarget(self, action: #selector(sigin), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let continueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Continue without account", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        btn.addTarget(self, action: #selector(continueWithoutAccount), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let googleBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.setImage(UIImage(named: "google")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.setTitle("Google", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(signinWithGoogle), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let wechatBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.tintColor = .white
        btn.setImage(UIImage(named: "wechat")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.setTitle("wechat", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(signinWithWechat), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupGesture()
    }
    
    fileprivate func setupView(){
        passwordTextField.rightView = rightBtn
        
        view.backgroundColor = .backgroundColor
        
        view.addSubviews(titleLabel, accountTextField, passwordTextField, forgotBtn, registerBtn, saperator, signinBtn, continueBtn, googleBtn, wechatBtn)
        
        titleLabel.anchors(centerX: view.centerXAnchor,
                           top: view.topAnchor,
                           topConstant: view.bounds.height * 0.2)
        
        accountTextField.anchors(centerX: view.centerXAnchor,
                                 top: titleLabel.bottomAnchor,
                                 topConstant: 40,
                                 width: view.widthAnchor,
                                 widthValue: 0.8,
                                 heightValue: 30)
        
        passwordTextField.anchors(centerX: view.centerXAnchor,
                                  top: accountTextField.bottomAnchor,
                                  topConstant: 24,
                                  width: accountTextField.widthAnchor,
                                  widthValue: 1,
                                  heightValue: 30)
        
        forgotBtn.anchors(top: passwordTextField.bottomAnchor,
                          topConstant: 24,
                          right: passwordTextField.rightAnchor)

        registerBtn.anchors(top: forgotBtn.bottomAnchor,
                            topConstant: 8,
                            right: passwordTextField.rightAnchor)
        
        signinBtn.anchors(centerX: view.centerXAnchor,
                          top: registerBtn.bottomAnchor,
                          topConstant: 36,
                          width: view.widthAnchor,
                          widthValue: 0.7,
                          heightValue: 45)
        
        continueBtn.anchors(centerX: view.centerXAnchor,
                            top: signinBtn.bottomAnchor,
                            topConstant: 8,
                            width: view.widthAnchor,
                            widthValue: 0.7,
                            heightValue: 45)
        
        saperator.anchors(centerX: view.centerXAnchor,
                          top: continueBtn.bottomAnchor,
                          topConstant: 36,
                          width: view.widthAnchor,
                          heightValue: 30)
        
        googleBtn.anchors(top: saperator.bottomAnchor,
                          topConstant: 30,
                          left: passwordTextField.leftAnchor,
                          width: view.widthAnchor,
                          widthValue: 0.35,
                          heightValue: 40)
        
        wechatBtn.anchors(top: saperator.bottomAnchor,
                          topConstant: 30,
                          right: passwordTextField.rightAnchor,
                          width: view.widthAnchor,
                          widthValue: 0.35,
                          heightValue: 40)
    }
    
    fileprivate func setupGesture(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
}

// MARK: - selector functions
extension LoginViewController{
    @objc
    fileprivate func handleTapGesture(){
        view.endEditing(true)
    }
    
    @objc
    fileprivate func showOrHide(){
        passwordTextField.isSecureTextEntry.toggle()
        rightBtn.setImage(passwordTextField.isSecureTextEntry ?
            UIImage(named: "hide") :
            UIImage(named: "show"), for: .normal)
    }
    
    @objc
    fileprivate func sigin(){
        print("sigin btn pressed!")
        if accountTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: accountTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
                if error != nil{
                    Utils.shard.showError(title: "Sign in failed!", "sigin with errors: \(String(describing: error))", strongSelf)
                }else{
                    // save the uid for widget extension fetching the event details
                    let defaults = UserDefaults(suiteName: "group.sharingForVitalDaysWidgetExt")
                    defaults?.set(authResult?.user.uid, forKey: "uid")
                    
                    // sign in successfully
                    self!.transitionToCountdownVC()
                }
            }
        }else{
            Utils.shard.showError(title: "Invalid account or password!", "Please enter the account and password!", self)
            return
        }
    }
    
    @objc
    fileprivate func continueWithoutAccount(){
        print("continue btn pressed!")
        
        let signedInAnonymous = UserDefaults.standard
        signedInAnonymous.set(true, forKey: "signedInAnonymous")
        
        self.view.window?.rootViewController = ContainerViewController()
        self.view.window?.makeKeyAndVisible()
    }
    
    fileprivate func transitionToCountdownVC(){
        self.view.window?.rootViewController = ContainerViewController()
        self.view.window?.makeKeyAndVisible()
    }
    
    @objc
    fileprivate func forgotPassword(){
        print("forgot btn clicked")
    }
    
    @objc
    fileprivate func registerAccount(){
        print("register btn clicked")
        let registerVC = UIStoryboard(name: "RegisterViewControllerStoryboard", bundle: nil)
        let vc = registerVC.instantiateViewController(withIdentifier: "RegisterVC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc
    fileprivate func signinWithGoogle(){
        print("sign in with google")
    }
    
    @objc
    fileprivate func signinWithWechat(){
        print("sign in with wechat")
    }
}
