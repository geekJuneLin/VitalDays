//
//  MyAccountViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 28/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController{
    
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
        let img = UIImageView(image: UIImage(named: "user"))
        field.placeholder = "Account"
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
        field.placeholder = "Password"
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
        label.font = UIFont.systemFont(ofSize: 24)
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
    
    let googleBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.5)
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
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.5)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    fileprivate func setupView(){
        passwordTextField.rightView = rightBtn
        
        view.backgroundColor = .backgroundColor
        
        view.addSubviews(titleLabel, accountTextField, passwordTextField, forgotBtn, registerBtn, saperator, googleBtn, wechatBtn)
        
        titleLabel.anchors(centerX: view.centerXAnchor,
                           top: view.topAnchor,
                           topConstant: view.bounds.height * 0.25)
        
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
        
        saperator.anchors(centerX: view.centerXAnchor,
                          top: registerBtn.bottomAnchor,
                          topConstant: 50,
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
}

extension MyAccountViewController{
    @objc
    fileprivate func showOrHide(){
        passwordTextField.isSecureTextEntry.toggle()
        rightBtn.setImage(passwordTextField.isSecureTextEntry ?
            UIImage(named: "hide") :
            UIImage(named: "show"), for: .normal)
    }
    
    @objc
    fileprivate func forgotPassword(){
        print("forgot btn clicked")
    }
    
    @objc
    fileprivate func registerAccount(){
        print("register btn clicked")
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
