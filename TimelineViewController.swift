//
//  Time_lineViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/18.
//

import UIKit
import Firebase
import FirebaseFirestore
class TimelineViewController: UIViewController {
    var db = Firestore.firestore()
    var  defaultText="デフォwwww"
    let df = DateFormatter()
    private let scrollView = UIScrollView()
    private let postStackView = UIStackView()
    private let tableView = UITableView()
    override func viewDidLoad(){
        super.viewDidLoad()
        setupView()
        setupCustomHeader()
        setupScrollView()
        setupStackView()
        Task {
            do {
                let _: () =  await getData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    private func setupView(){
        self.title=""
        view.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.0)
    }
    private func getData() async{
        db.collection("Post").order(by: "date", descending: true)
            .getDocuments { (querySnapshot, error) in
            if let error = error {
                print("投稿の取得に失敗しました。: \(error)")
                return // エラー発生時は処理を中断
            }
            
            guard let documents = querySnapshot?.documents else {
                print("データがありません")
                return // ドキュメントが見つからない場合は処理を中断
            }
            
            for document in documents {
                // ドキュメントのデータを取得
                guard let data = document.data() as? [String: Any] else {
                    print("データにアクセスできませんでした。")
                    continue // 次のドキュメントへ
                }
              
                let date_timestamp = data["date"] as? Timestamp
                let date =  date_timestamp?.dateValue()
                let text = data["text"] as? String
                let userid = data["userId"] as? String
                var username = data["displayName"] as? String
                if ((data["official"]) != nil){
                    //ユーザーの投稿が公式アカウントだった時の処理
                    username = (username ?? "")+":official"
                }
                
//                print(date,text,userid,username)
                let postView = self.createPostView(postText: text ?? self.defaultText,userId:userid ?? self.defaultText,userName:username ?? self.defaultText, date: date ?? Date.now)
                self.postStackView.addArrangedSubview(postView)
            }
        }
        
    }
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func setupStackView() {
        scrollView.addSubview(postStackView)
        postStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            postStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            postStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            postStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            postStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        postStackView.axis = .vertical
        postStackView.distribution = .fillEqually
        postStackView.alignment = .fill
    }

    private func createPostView(postText: String, userId: String, userName: String, date: Date) -> UIView {
        let postView = UIView()
        postView.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.0) // #2A2A2A
//        postView.layer.cornerRadius = 15
        
        let userIconImageView = UIImageView(image: UIImage(named: "defaultUserIcon"))
        userIconImageView.contentMode = .scaleAspectFill
        userIconImageView.layer.cornerRadius = 10
        userIconImageView.clipsToBounds = true
        
        let userNameLabel = UILabel()
        userNameLabel.text = userName
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        userNameLabel.textColor = .white
        
        let userIdLabel = UILabel()
        userIdLabel.text = "@\(userId)"
        userIdLabel.font = UIFont.systemFont(ofSize: 12)
        userIdLabel.textColor = UIColor(white: 0.6, alpha: 1.0)
        
        self.df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let postTimeLabel = UILabel()
        postTimeLabel.text = df.string(from: date)
        postTimeLabel.font = UIFont.systemFont(ofSize: 12)
        postTimeLabel.textColor = UIColor(white: 0.6, alpha: 1.0)
        
        let postTextLabel = UILabel()
        postTextLabel.text = postText
        postTextLabel.font = UIFont.systemFont(ofSize: 14)
        postTextLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.6, alpha: 1.0) // #FFFF99
        postTextLabel.numberOfLines = 0


        
        postView.addSubview(userIconImageView)
        postView.addSubview(userNameLabel)
        postView.addSubview(userIdLabel)
        postView.addSubview(postTimeLabel)
        postView.addSubview(postTextLabel)
        
        userIconImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userIdLabel.translatesAutoresizingMaskIntoConstraints = false
        postTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        postTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),///postのviewの高さ
            
            userIconImageView.topAnchor.constraint(equalTo: postView.topAnchor, constant: 15),
            userIconImageView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 15),
            userIconImageView.widthAnchor.constraint(equalToConstant: 40),
            userIconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            userNameLabel.topAnchor.constraint(equalTo: postView.topAnchor, constant: 15),
            userNameLabel.leadingAnchor.constraint(equalTo: userIconImageView.trailingAnchor, constant: 10),
            
            userIdLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor),
            userIdLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 5),
            
            postTimeLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 2),
            postTimeLabel.leadingAnchor.constraint(equalTo: userIconImageView.trailingAnchor, constant: 10),
            
            postTextLabel.topAnchor.constraint(equalTo: postTimeLabel.bottomAnchor, constant: 10),
            postTextLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 15),
            postTextLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -15),
        ])
        
        
        return postView
    }
}
#Preview(){
    TimelineViewController()
}
