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
    var  defaultText=""
    let df = DateFormatter()
    private let scrollView = UIScrollView()
    private let postStackView = UIStackView()
    private let tableView = UITableView()
    private let addPostbutton = UIButton()
    override func viewDidLoad(){
        super.viewDidLoad()
        setupView()
        setupCustomHeader()
        setupScrollView()
        setupStackView()
        setupAddpostButton()
        Task {
            do {
                let _: () =  await getData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    private func setupView(){
        self.title=""
        view.backgroundColor = AccentColor_gray
    }
    private func getData() async {
        let db = Firestore.firestore()
        
        do {
            // 非同期でドキュメントを取得
            let querySnapshot = try await db.collection("Post")
                .order(by: "date", descending: true)
                .getDocuments()
            
            // ドキュメントが存在するか確認
            guard !querySnapshot.documents.isEmpty else {
                print("データがありません")
                return // ドキュメントが見つからない場合は処理を中断
            }
            
            for document in querySnapshot.documents {
                // 各ドキュメントのデータにアクセス
                let data = document.data()
                
                let date_timestamp = data["date"] as? Timestamp
                let date =  date_timestamp?.dateValue()
                let text = data["text"] as? String
                let userid = data["userId"] as? String
                var username = data["displayName"] as? String
                if ((data["official"]) != nil){
                    //ユーザーの投稿が公式アカウントだった時の処理
                    username = (username ?? "")+":official"
                }

//                print(coin)
//                if coin==0{
//                    print
//                    break
//                }
                
//                print(date,text,userid,username)
                let postView = self.createPostView(postText: text ?? self.defaultText,userId:userid ?? self.defaultText,userName:username ?? self.defaultText, date: date ?? Date.now)
                self.postStackView.addArrangedSubview(postView)
            }
            
        } catch {
            // エラーが発生した場合の処理
            print("投稿の取得に失敗しました: \(error.localizedDescription)")
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
        postView.backgroundColor = AccentColor_gray
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
        postTextLabel.textColor = AccentColor_yellow
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
            addPostbutton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addPostbutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        
        return postView
    }
    private func setupAddpostButton(){
        let image = UIImage(systemName: "plus.bubble")?.withTintColor(.black)
        addPostbutton.setImage(image, for: .normal)
        addPostbutton.backgroundColor = AccentColor_yellow
        addPostbutton.setTitleColor(.black, for: .normal)
        addPostbutton.layer.cornerRadius = 10
        addPostbutton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addPostbutton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addPostbutton)
        addPostbutton.addTarget(self, action: #selector(AddPostButtonTapped), for: .touchUpInside)
    }
    @objc func AddPostButtonTapped(){
        let AddPost = AddPostViewController()
        self.navigationController?.pushViewController(AddPost, animated: true)
    }
}
#Preview(){
    TimelineViewController()
}
