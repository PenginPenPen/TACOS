//
//  AddPostViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/18.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class AddPostViewController: UIViewController {
    var db = Firestore.firestore()
    private let TextField = UITextField()
    private let PostButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        setupView()
        setupTextField()
        setupPostButton()
        setupConstraints()
        
        // Do any additional setup after loading the view.
    }
    private func setupView(){
        self.title="投稿追加画面"
        view.backgroundColor = .white
    }
    private func getUserData() -> String? {
        if let user = Auth.auth().currentUser {
            return user.email
        } else {
            print("ログインしてないよ")
            let LoginViewController = LoginViewController()
            self.navigationController?.pushViewController(LoginViewController, animated: true)
            return nil
        }
    }
    private func setupTextField() {
        TextField.placeholder = "投稿内容をここに入力"
        view.addSubview(TextField)
        TextField.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setupPostButton(){
        PostButton.setTitle("投稿", for: UIControl.State.normal)
        PostButton.setTitleColor(.black, for: .normal)
        PostButton.addTarget(self, action: #selector(AddPostButtonTapped), for: .touchUpInside)
        view.addSubview(PostButton)
        PostButton.translatesAutoresizingMaskIntoConstraints = false
    }
    private func  setupConstraints(){
        NSLayoutConstraint.activate([
                 TextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                 TextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                 
                 PostButton.topAnchor.constraint(equalTo: TextField.bottomAnchor),
                 PostButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
             ])
    }
    private func getField() -> (String)? {
        guard let postText = TextField.text, !postText.isEmpty else {
            print("テキストフィールドが空白です。")
            return nil
        }
        return (postText)
    }
    @objc func AddPostButtonTapped(){
        let uuid = UUID()
        let email=getUserData()
        let text = getField()
        db.collection("Post").document().setData([
                    "date": Date(),
                    "userId": uuid.uuidString,
                    "username": email ?? "匿名",
                    "text": text ?? "空白"
        ])
        print("投稿内容\(String(describing: text))")
        let TimeLine = TimelineViewController()
        self.navigationController?.pushViewController(TimeLine, animated: true)
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
    AddPostViewController()
}
