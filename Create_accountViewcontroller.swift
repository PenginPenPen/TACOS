//
//  Create_userViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/17.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
class Create_accountViewcontroller: UIViewController {
    private let usernamePasswordStackView = UIStackView()
    private let createAccountButton = UIButton()
    private let messageLabel = UILabel()
    private let emailField = UITextField()
    private let passwordField = UITextField()
//    var Email = String()
//    var Passward = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        setupTextField()
        setupButton()
        setupConstraints()
        
    }
    private func setupView(){
        self.title="アカウント作成画面"
        view.backgroundColor =  UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0)
    }
    private func setupStackView() {
        usernamePasswordStackView.axis = .vertical
        usernamePasswordStackView.distribution = .fillProportionally
        usernamePasswordStackView.alignment = .center
        view.addSubview(usernamePasswordStackView)
    }
    private func setupButton(){
        createAccountButton.setTitle("アカウント作成", for: UIControl.State.normal)
        createAccountButton.backgroundColor = .black
        createAccountButton.setTitleColor(UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0), for: .normal)
        createAccountButton.layer.cornerRadius = 20
        createAccountButton.addTarget(self, action: #selector(CreateAccontButtonTapped), for: .touchUpInside)
        usernamePasswordStackView.addArrangedSubview(createAccountButton)
        
    }
    private func setupConstraints() {
        usernamePasswordStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([usernamePasswordStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     usernamePasswordStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     usernamePasswordStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     usernamePasswordStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
    }
    private func setupTextField() {
        emailField.placeholder = "メールアドレスをここに入力"
        emailField.borderStyle = .roundedRect
        emailField.textContentType = .emailAddress
        usernamePasswordStackView.addArrangedSubview(emailField)
        
        passwordField.placeholder = "ここにパスワードを入力"
        passwordField.borderStyle = .roundedRect
        passwordField.textContentType = .password
        passwordField.isSecureTextEntry = true // パスワードを隠す
        usernamePasswordStackView.addArrangedSubview(passwordField)
    }

    private func getLoginCredentials() -> (email: String, password: String)? {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            print("メールアドレスまたはパスワードが空です")
            return nil
        }
        return (email, password)
    }
    
    @objc func CreateAccontButtonTapped() {
        if let credentials = getLoginCredentials() {
            print("成功！")
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { authResult, error in
                if let error = error {
                    print("アカウントの作成に失敗", error.localizedDescription)
                }else{
                    print("アカウント作成成功")
                    self.transitionLoginView()
                    
                }
            }
        }
    }
    func transitionLoginView(){
        let LoginViewController = LoginViewController()
        self.navigationController?.pushViewController(LoginViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
#Preview{
    Create_accountViewcontroller()
}

