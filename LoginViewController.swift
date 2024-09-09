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

class LoginViewController: UIViewController, UITextFieldDelegate{
    private let logolabel = UILabel()
    private let formStackView = UIStackView()
    private let loginButton = UIButton()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let forgotPassword = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        setupLogolabel()
        setupTextField()
        setupButton()
        setupForgotPasswordButton()
        setupConstraints()

        emailField.delegate = self
        passwordField.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    private func setupView(){
//        self.title="ログイン画面"
        view.backgroundColor = AccentColor_yellow
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
        loginButton.setTitleColor(AccentColor_yellow, for: .normal)
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
        emailField.backgroundColor = AccentColor_yellow
        formStackView.addArrangedSubview(emailField)
        
        passwordField.placeholder = "ここにパスワードを入力"
        passwordField.borderStyle = .roundedRect
        passwordField.textContentType = .password
        passwordField.isSecureTextEntry = true
        passwordField.layer.cornerRadius = 25
        passwordField.borderStyle = .none
        passwordField.backgroundColor = AccentColor_yellow
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
        let credentials = getLoginCredentials()
//            Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { [weak self] authResult, error in
//                guard self != nil else { return }
//                if let error = error {
//                    print("ログインに失敗", error.localizedDescription)
//                }else{
//                    print("ログインに成功")
//                    let TimeLine = TimelineViewController()
//                    self?.navigationController?.pushViewController(TimeLine, animated: true)
//                }
//            }
//        }
        LoginManager.shared.login(email: credentials?.email ?? "", password: credentials?.password ?? "") { result in
                   switch result {
                   case .success(let user):
                       print("ログイン成功: \(user.uid)")
                       let TimeLine = TimelineViewController()
                       self.navigationController?.pushViewController(TimeLine, animated: true)
                   case .failure(let error):
                       print("ログインに失敗", error.localizedDescription)
                   }
       }
    }
}

#Preview(){
    LoginViewController()
}
