//
//  ViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/15.
//

import UIKit
import Firebase
import FirebaseFirestore
class DebugPageViewController: UIViewController {
    let LoginButton = UIButton()
    let CreateaccountButton = UIButton()
    let TimelineButton = UIButton()
    let AddPostButton = UIButton()
    let stackView = UIStackView()
    var db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "デバッグ"
        stackView.axis = .vertical
        view.backgroundColor = .white
        LoginButton.setTitle("ログイン", for: UIControl.State.normal)
        LoginButton.setTitleColor(.black, for: .normal)
        CreateaccountButton.setTitle("アカウント作成", for: UIControl.State.normal)
        CreateaccountButton.setTitleColor(.black, for: .normal)
        LoginButton.addTarget(self, action: #selector(LoginButtonTapped), for: .touchUpInside)
        CreateaccountButton.addTarget(self, action: #selector(CreateaccountButtonTapped), for: .touchUpInside)
        TimelineButton.setTitle("タイムライン", for: UIControl.State.normal)
        TimelineButton.setTitleColor(.black, for: .normal)
        TimelineButton.addTarget(self, action: #selector(TimelineButtonTapped), for: .touchUpInside)
        
        AddPostButton.setTitle("投稿", for: UIControl.State.normal)
        AddPostButton.setTitleColor(.black, for: .normal)
        AddPostButton.addTarget(self, action: #selector(AddPostButtonTapped), for: .touchUpInside)

        stackView.addArrangedSubview(LoginButton)
        stackView.addArrangedSubview(CreateaccountButton)
        stackView.addArrangedSubview(TimelineButton)
        stackView.addArrangedSubview(AddPostButton)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    @objc func LoginButtonTapped() {
        let LoginViewController = LoginViewController() // 遷移先のViewController
        self.navigationController?.pushViewController(LoginViewController, animated: true)
    }
    @objc func CreateaccountButtonTapped() {
        let Createaccount = CreateAccountViewcontroller()// 遷移先のViewController
        self.navigationController?.pushViewController(Createaccount, animated: true)
    }
    @objc func TimelineButtonTapped(){
        let TimeLine = TimelineViewController()
        self.navigationController?.pushViewController(TimeLine, animated: true)
    }
    @objc func AddPostButtonTapped(){
        let uuid = UUID()
        db.collection("Post").document().setData([
                    "date": Date(),
                    "userId": uuid.uuidString,
                    "username": "TestUser" + uuid.uuidString,
                    "text": "Welcome to TACOS!!!"
        ])
    }

}
