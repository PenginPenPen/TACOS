//
//  ViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/15.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    let Signbutton = UIButton()
    let Createaccount = UIButton()
    let stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "test"
        stackView.axis = .vertical
        view.backgroundColor = .white
        Signbutton.setTitle("ログイン", for: UIControl.State.normal)
        Signbutton.setTitleColor(.black, for: .normal)
        Createaccount.setTitle("アカウント作成", for: UIControl.State.normal)
        Createaccount.setTitleColor(.black, for: .normal)
        Signbutton.addTarget(self, action: #selector(SignButtonTapped), for: .touchUpInside)
        Createaccount.addTarget(self, action: #selector(Create_accontButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(Signbutton)
        stackView.addArrangedSubview(Createaccount)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    @objc func SignButtonTapped() {
        let LoginViewController = LoginViewController() // 遷移先のViewController
        self.navigationController?.pushViewController(LoginViewController, animated: true)
    }
    @objc func Create_accontButtonTapped() {
        let Createaccount = Create_userViewController() // 遷移先のViewController
        self.navigationController?.pushViewController(Createaccount, animated: true)
    }

}

