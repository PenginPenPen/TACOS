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
    private let CreatedDate = UIDatePicker()
    private let DisplayName = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        getUserdata()
        setupLabels()
        setupConstraints()
    }
    private func setupView(){
        self.title = "ユーザープロフィール"
        view.backgroundColor = .white
    }
    func getUserdata(){
        let uid = Auth.auth().currentUser?.uid
        let userRef = db.collection("Users").document(uid!)
        userRef.getDocument { (document, error) in
          if let document = document, document.exists {
              let data = document.data()
              let date_timestamp = data?["createdAt"] as! Timestamp
              self.created_date = date_timestamp.dateValue()
              self.displayName = data?["displayName"] as? String
              self.DisplayName.text = self.displayName
              self.CreatedDate.date = self.created_date ?? Date.now
          } else {
            print("Document does not exist")
          }
        }
    }
    private func setupLabels(){
        DisplayName.textColor = .black
        DisplayName.translatesAutoresizingMaskIntoConstraints = false
        CreatedDate.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(DisplayName)
        view.addSubview(CreatedDate)
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            DisplayName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            DisplayName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                 
            CreatedDate.topAnchor.constraint(equalTo: DisplayName.bottomAnchor),
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
