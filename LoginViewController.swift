//
//  LoginViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/15.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController{
    private let emailPasswordStackView = UIStackView()
    private let loginButton = UIButton()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let forgotPassword = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        setupConstraints()
        setupTextField()
        setupButton()
        setupForgotPasswordButton()
    }
    private func setupView(){
        self.title="ログイン画面"
        view.backgroundColor =  UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0)
    }
    private func setupStackView() {
        emailPasswordStackView.axis = .vertical
        emailPasswordStackView.distribution = .fillProportionally
        emailPasswordStackView.alignment = .center
        view.addSubview(emailPasswordStackView)
    }
    private func setupButton(){
        loginButton.setTitle("ログイン", for: UIControl.State.normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0), for: .normal)
        loginButton.layer.cornerRadius = 20
        loginButton.addTarget(self, action: #selector(LoginButtonTapped), for: .touchUpInside)
        emailPasswordStackView.addArrangedSubview(loginButton)
        
    }
    private func  setupConstraints(){
        emailPasswordStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([emailPasswordStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     emailPasswordStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     emailPasswordStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     emailPasswordStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
    }
    private func setupTextField() {
        emailField.placeholder = "メールアドレスをここに入力"
        emailField.borderStyle = .roundedRect
        emailField.textContentType = .emailAddress
        emailPasswordStackView.addArrangedSubview(emailField)
        
        passwordField.placeholder = "ここにパスワードを入力"
        passwordField.borderStyle = .roundedRect
        passwordField.textContentType = .password
        passwordField.isSecureTextEntry = true
        emailPasswordStackView.addArrangedSubview(passwordField)
    }
    private func setupForgotPasswordButton(){
        forgotPassword.setTitle("パスワードを忘れた場合はこちら", for: UIControl.State.normal)
        forgotPassword.setTitleColor(.black, for: .normal)
        emailPasswordStackView.addArrangedSubview(forgotPassword)
    }
    private func getLoginCredentials() -> (email: String, password: String)? {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            print("メールアドレスまたはパスワードが空です")
            return nil
        }
        return (email, password)
    }
    @objc func LoginButtonTapped() {
        if let credentials = getLoginCredentials() {
            Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { [weak self] authResult, error in
                guard self != nil else { return }
                if let error = error {
                    print("ログインに失敗", error.localizedDescription)
                }else{
                    print("ログインに成功")
                }
            }
        }
    }
}

#Preview(){
    LoginViewController()
}
