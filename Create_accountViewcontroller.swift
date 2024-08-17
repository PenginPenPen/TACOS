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
    let CreateAccont = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title="アカウント作成画面"
        CreateAccont.setTitle("アカウント作成", for: UIControl.State.normal)
        CreateAccont.setTitleColor(.black, for: .normal)
        CreateAccont.addTarget(self, action: #selector(CreateAccontButtonTapped), for: .touchUpInside)
        view.addSubview(CreateAccont)
        CreateAccont.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            CreateAccont.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            CreateAccont.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            CreateAccont.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            CreateAccont.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
       
        // Do any additional setup after loading the view.
    }
    
    
    @objc func CreateAccontButtonTapped() {
        print("成功！")
        Auth.auth().createUser(withEmail: "test@gmail.com", password: "pass123456") { authResult, error in
        if let error = error {
            print("アカウントの作成に失敗", error.localizedDescription)
        }else{
            print("アカウント作成成功")
        }
        }
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
