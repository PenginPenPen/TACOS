//
//  ViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/15.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    let LoginButton = UIButton()
    let CreateaccountButton = UIButton()
    let stackView = UIStackView()
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
        stackView.addArrangedSubview(LoginButton)
        stackView.addArrangedSubview(CreateaccountButton)
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
        let Createaccount = Create_accountViewcontroller()// 遷移先のViewController
        self.navigationController?.pushViewController(Createaccount, animated: true)
    }

}

