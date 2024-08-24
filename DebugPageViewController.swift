//
//  ViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/15.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
class DebugPageViewController: UIViewController {
    let loginButton = UIButton()
    let createAccountButton = UIButton()
    let timelineButton = UIButton()
    let addPostButton = UIButton()
    let logoutButton = UIButton()
    let stackView = UIStackView()
    var db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "デバッグ"

        setupStackView()
        setupButtons()
        addButtonsToStackView()
        layoutStackView()
    }

    private func setupStackView() {
        stackView.axis = .vertical
        view.backgroundColor = .white
    }

    private func setupButtons() {
        loginButton.setTitle("ログイン", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        createAccountButton.setTitle("アカウント作成", for: .normal)
        createAccountButton.setTitleColor(.black, for: .normal)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)

        timelineButton.setTitle("タイムライン", for: .normal)
        timelineButton.setTitleColor(.black, for: .normal)
        timelineButton.addTarget(self, action: #selector(timelineButtonTapped), for: .touchUpInside)

        addPostButton.setTitle("投稿ページ", for: .normal)
        addPostButton.setTitleColor(.black, for: .normal)
        addPostButton.addTarget(self, action: #selector(addPostViewtransitionButtonTapped), for: .touchUpInside)

        logoutButton.setTitle("ログアウト", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)

    }

    private func addButtonsToStackView() {
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(createAccountButton)
        stackView.addArrangedSubview(timelineButton)
        stackView.addArrangedSubview(addPostButton)
    }

    private func layoutStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)

        ])
    }
    @objc func loginButtonTapped() {
        let LoginViewController = LoginViewController() // 遷移先のViewController
        self.navigationController?.pushViewController(LoginViewController, animated: true)
    }
    @objc func createAccountButtonTapped() {
        let Createaccount = CreateAccountViewcontroller()// 遷移先のViewController
        self.navigationController?.pushViewController(Createaccount, animated: true)
    }
    @objc func timelineButtonTapped(){
        let TimeLine = TimelineViewController()
        self.navigationController?.pushViewController(TimeLine, animated: true)
    }
//    @objc func AddPostButtonTapped(){
//        let uuid = UUID()
//        db.collection("Post").document().setData([
//                    "date": Date(),
//                    "userId": uuid.uuidString,
//                    "username": "TestUser\(Int.random(in: 1000..<5000))",
//                    "text": "Welcome to TACOS!!!"
//        ])
//    }
    @objc func addPostViewtransitionButtonTapped(){
        let AddPost = AddPostViewController()
        self.navigationController?.pushViewController(AddPost, animated: true)
    }
    @objc func logoutButtonTapped(){
        do {
            try Auth.auth().signOut()
        }
        catch let error as NSError {
            print(error)
        }
        print("ログアウトしたよ")
    }
    

}
