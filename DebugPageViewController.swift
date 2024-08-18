//
//  ViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/15.
//

import UIKit
import Firebase
class DebugPageViewController: UIViewController {
    let LoginButton = UIButton()
    let CreateaccountButton = UIButton()
    let TimelineButton = UIButton()
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
        TimelineButton.setTitle("タイムライン", for: UIControl.State.normal)
        TimelineButton.setTitleColor(.black, for: .normal)
        TimelineButton.addTarget(self, action: #selector(TimelineButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(LoginButton)
        stackView.addArrangedSubview(CreateaccountButton)
        stackView.addArrangedSubview(TimelineButton)
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

}

