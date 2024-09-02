//
//  UserProfileViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/25.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class UserProfileViewController: UIViewController {
    var db = Firestore.firestore()
    var created_date:Date?
    var displayName:String?
    let df = DateFormatter()
    private let CreatedDate = UILabel()
    private let DisplayName = UILabel()
    private let TotalCoin = UILabel()
    private let stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        getUserdata()
        setupStackview()
        setupLabels()
        setupConstraints()
    }
    private func setupView(){
        self.title = "profile"
        view.backgroundColor = .white
    }
    func getUserdata(){
        if LoginManager.shared.isLoggedIn {
                let uid = Auth.auth().currentUser?.uid
                let userRef = db.collection("Users").document(uid!)
                userRef.getDocument { (document, error) in
                  if let document = document, document.exists {
                      let data = document.data()
                      self.df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                      let date_timestamp = data?["createdAt"] as! Timestamp
                      self.created_date = date_timestamp.dateValue()
                      self.displayName = data?["displayName"] as? String
                      self.DisplayName.text = self.displayName
                      self.CreatedDate.text = self.df.string(from: self.created_date ?? Date.now)
                      self.TotalCoin.text = data?["coin"] as? String
                  } else {
                    print("Document does not exist")
                  }
                }
        } else {
            print("ログインしてません")
            let Createaccount = CreateAccountViewcontroller()
            self.navigationController?.pushViewController(Createaccount, animated: true)
        }
    }
    private func setupLabels(){
        DisplayName.textColor = .black
        DisplayName.translatesAutoresizingMaskIntoConstraints = false
        CreatedDate.textColor = .black
        CreatedDate.translatesAutoresizingMaskIntoConstraints = false
        TotalCoin.textColor = .black
        TotalCoin.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(DisplayName)
        stackView.addArrangedSubview(CreatedDate)
        stackView.addArrangedSubview(TotalCoin)
        
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    private func setupStackview(){
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
#Preview(){
    UserProfileViewController()
}
