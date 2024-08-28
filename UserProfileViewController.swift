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
    private let stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        getUserdata()
        setupLabels()
        setupConstraints()
    }
    private func setupView(){
        self.title = "profile"
        view.backgroundColor = .white
    }
    func getUserdata(){
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
          } else {
            print("Document does not exist")
          }
        }
    }
    private func setupLabels(){
        DisplayName.textColor = .black
        DisplayName.translatesAutoresizingMaskIntoConstraints = false
        CreatedDate.textColor = .black
        CreatedDate.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(DisplayName)
        stackView.addArrangedSubview(CreatedDate)
    }
    private func setupConstraints(){

    }
    private func setupStackview(){
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
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
