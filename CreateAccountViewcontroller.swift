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
class CreateAccountViewcontroller: UIViewController {
    private let formStackView = UIStackView()
    private let createAccountButton = UIButton()
    private let messageLabel = UILabel()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let forgotPassword = UIButton()
    private let transitionLogin = UIButton()
    private let logolabel = UILabel()
    var AccentColor=UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0)
    //    var Email = String()
    //    var Passward = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        setupLogolabel()
        setupTextField()
        setupButton()
        setupConstraints()
        setupTransitionLoginButton()
        
    }
    private func setupView(){
        //        self.title="アカウント作成画面"
        view.backgroundColor = AccentColor
    }
    private func setupLogolabel() {
        logolabel.text = "WELCOME"
        logolabel.font = UIFont(name: "Impact", size: 48)
        logolabel.textColor = .black
        logolabel.textAlignment = .center
        formStackView.addArrangedSubview(logolabel)
    }
    private func setupStackView() {
        formStackView.axis = .vertical
        formStackView.spacing = 20
        formStackView.distribution = .fill
        //        formStackView.alignment = .center
        view.addSubview(formStackView)
    }
    private func setupButton(){
        createAccountButton.setTitle("アカウント作成", for: UIControl.State.normal)
        createAccountButton.titleLabel?.font = UIFont(name: "Impact", size: 14)
        createAccountButton.backgroundColor = .black
        createAccountButton.setTitleColor(UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0), for: .normal)
        createAccountButton.layer.cornerRadius = 35
        createAccountButton.addTarget(self, action: #selector(CreateAccontButtonTapped), for: .touchUpInside)
        formStackView.addArrangedSubview(createAccountButton)
        
    }
    private func setupConstraints() {
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([formStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                                     formStackView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20),
                                     formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     formStackView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant:-20),
                                     logolabel.heightAnchor.constraint(equalToConstant: 200),
                                     emailField.heightAnchor.constraint(equalToConstant: 70),
                                     passwordField.heightAnchor.constraint(equalToConstant: 70),
                                     createAccountButton.heightAnchor.constraint(equalToConstant: 70)
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
        passwordField.layer.cornerRadius  = 25
        passwordField.isSecureTextEntry = true
        passwordField.borderStyle = .none
        formStackView.addArrangedSubview(passwordField)
    }
    
    private func getLoginCredentials() -> (email: String, password: String)? {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            print("メールアドレスまたはパスワードが空です")
            return nil
        }
        return (email, password)
    }
    //    private func setupForgotPasswordButton(){
    //        forgotPassword.setTitle("パスワードを忘れた場合はこちら", for: UIControl.State.normal)
    //        forgotPassword.setTitleColor(.black, for: .normal)
    //        usernamePasswordStackView.addArrangedSubview(forgotPassword)
    //    }
    private func setupTransitionLoginButton(){
        transitionLogin.setTitle("ログインはこちら", for: UIControl.State.normal)
        transitionLogin.setTitleColor(.black, for: .normal)
        formStackView.addArrangedSubview(transitionLogin)
        transitionLogin.addTarget(self, action: #selector(TransitionLoginButtonTapped), for: .touchUpInside)
    }
    @objc func CreateAccontButtonTapped() {
        if let credentials = getLoginCredentials() {
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { authResult, error in
                if let error = error {
                    print("アカウントの作成に失敗", error.localizedDescription)
                }else{
                    print("アカウント作成成功")
                    //                    self.CreateUserData()
                    self.transitionLoginView()
                }
            }
        }
    }
    @objc func TransitionLoginButtonTapped(){
        transitionLoginView()
    }
    func transitionLoginView(){
        let LoginViewController = LoginViewController()
        self.navigationController?.pushViewController(LoginViewController, animated: true)
    }
    func CreateUserData(){
        let uuid = UUID()
        let db = Firestore.firestore()
        
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                let userRef = db.collection("Users").document(user.uid)
                userRef.setData([
                    "displayName": user.displayName ?? "名無しさん\(uuid.uuidString)",
                    "userId":user.uid,
                    "photoURL": user.photoURL?.absoluteString ?? "",
                    "createdAt": FieldValue.serverTimestamp()
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("User data saved successfully!")
                    }
                }
                //            }
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
                CreateAccountViewcontroller()
            }
            
        }
    }
}
