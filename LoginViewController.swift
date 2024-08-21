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
    private let logolabel = UILabel()
    private let formStackView = UIStackView()
    private let loginButton = UIButton()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let forgotPassword = UIButton()
    var AccentColor=UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        setupLogolabel()
        setupTextField()
        setupButton()
        setupForgotPasswordButton()
        setupConstraints()
    }
    private func setupView(){
//        self.title="ログイン画面"
        view.backgroundColor =  AccentColor
    }
    private func setupLogolabel() {
        logolabel.text = "LOGIN"
        logolabel.font = UIFont(name: "Impact", size: 48)
        logolabel.textColor = .black
        logolabel.textAlignment = .center
        formStackView.addArrangedSubview(logolabel)
    }
    private func setupStackView() {
        formStackView.axis = .vertical
        formStackView.spacing = 20
        formStackView.distribution = .fill
        view.addSubview(formStackView)
    }
    private func setupButton(){
        loginButton.setTitle("ログイン", for: UIControl.State.normal)
        loginButton.backgroundColor = .black
        loginButton.titleLabel?.font = UIFont(name: "Impact", size: 14)
        loginButton.setTitleColor(AccentColor, for: .normal)
        loginButton.layer.cornerRadius = 35
        loginButton.addTarget(self, action: #selector(LoginButtonTapped), for: .touchUpInside)
        formStackView.addArrangedSubview(loginButton)
        
    }
    private func  setupConstraints(){
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            formStackView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            formStackView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant:-20),
            logolabel.heightAnchor.constraint(equalToConstant: 200),
            emailField.heightAnchor.constraint(equalToConstant: 70),
            passwordField.heightAnchor.constraint(equalToConstant: 70),
            loginButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    private func setupTextField() {
        emailField.placeholder = "メールアドレスをここに入力"
        emailField.borderStyle = .roundedRect
        emailField.textContentType = .emailAddress
        emailField.layer.cornerRadius = 25
        emailField.borderStyle = .none
        emailField.backgroundColor = AccentColor
        formStackView.addArrangedSubview(emailField)
        
        passwordField.placeholder = "ここにパスワードを入力"
        passwordField.borderStyle = .roundedRect
        passwordField.textContentType = .password
        passwordField.isSecureTextEntry = true
        passwordField.layer.cornerRadius = 25
        passwordField.borderStyle = .none
        passwordField.backgroundColor = AccentColor
        formStackView.addArrangedSubview(passwordField)
    }
    private func setupForgotPasswordButton(){
        forgotPassword.setTitle("パスワードを忘れた場合はこちら", for: UIControl.State.normal)
        forgotPassword.setTitleColor(.black, for: .normal)
        formStackView.addArrangedSubview(forgotPassword)
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
