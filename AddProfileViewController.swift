//
//  AddProfileViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/25.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
class AddProfileViewController: UIViewController {
    private let displayName = UITextField()
    private let formStackView = UIStackView()
    private let displayNameField = UITextField()
    private let saveButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        setupTextField()
        setupButton()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    private func setupView(){
        self.title="ユーザープロフィール作成"
        view.backgroundColor = .white
    }
    private func setupStackView() {
        formStackView.axis = .vertical
        formStackView.spacing = 20
        formStackView.distribution = .fill
        //        formStackView.alignment = .center
        view.addSubview(formStackView)
    }
    private func setupTextField() {
        displayNameField.placeholder = "ニックネーム"
        displayNameField.borderStyle = .roundedRect
        displayNameField.textContentType = .emailAddress
        displayNameField.layer.cornerRadius = 25
        displayNameField.borderStyle = .none
        displayNameField.backgroundColor = .white
        formStackView.addArrangedSubview(displayNameField)
    }
    private func setupButton(){
        saveButton.setTitle("Save", for: UIControl.State.normal)
        saveButton.titleLabel?.font = UIFont(name: "Impact", size: 14)
        saveButton.backgroundColor = .black
        saveButton.setTitleColor(UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0), for: .normal)
        saveButton.layer.cornerRadius = 35
        saveButton.addTarget(self, action: #selector(SaveButtonTapped), for: .touchUpInside)
        formStackView.addArrangedSubview(saveButton)
        
    }
    private func setupConstraints() {
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([formStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                                     formStackView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20),
                                     formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     formStackView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant:-20),
                                    ])
    }
    private func CreateUserData(DisplayName:String){
        let db = Firestore.firestore()
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                let userRef = db.collection("Users").document(user.uid)
                userRef.setData([
                    "displayName": DisplayName, //ユーザーのニックネーム
                    "official" : false, //公式アカウント
                    "userId":user.uid,
                    "photoURL": user.photoURL?.absoluteString ?? "", //ユーザーのアイコン
                    "createdAt": FieldValue.serverTimestamp()
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("User data saved successfully!")
                    }
                }
            }
            
        }
    }
    private func getField() -> (String)? {
        guard let displayName = displayNameField.text, !displayName.isEmpty else{
            print("フィールドが空です")
            return nil
        }
        return (displayName)
    }
    @objc func SaveButtonTapped(){
        print(getField() ?? "")
        CreateUserData(DisplayName: getField() ?? "")
        let TimeLine = TimelineViewController()
        self.navigationController?.pushViewController(TimeLine, animated: true)
    }
}
#Preview(){
    AddProfileViewController()
}
