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
    private let scrollView = UIScrollView()
    private let postStackView = UIStackView()
    override func viewDidLoad(){
        super.viewDidLoad()
        setupView()
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
        self.title="タイムライン"
        view.backgroundColor = .black
    }
    private func getData() async{
        //        let docRef = db.collection("TestData").document("TestPost")
        //        do {
        //            let document = try await docRef.getDocument()
        //            if document.exists {
        //                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
        //                print(dataDescription)
        //            } else {
        //                print("Document does not exist")
        //            }
        //        } catch {
        //            print("Error getting document: \(error)")
        //        }
        db.collection("Post").getDocuments { (querySnapshot, error) in
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
                
                let date = data["date"] as? Timestamp //投稿日時の管理の仕方を変える
                let text = data["text"] as? String
                let userid = data["userId"] as? String
                let username = data["username"] as? String
                
                print(date,text,userid,username)
                let postView = self.createPostView(postText: text ?? self.defaultText,userId:userid ?? self.defaultText,userName:username ?? self.defaultText)
                self.postStackView.addArrangedSubview(postView)
            }
        }
        
    }
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
    private func createPostView(postText: String,userId:String,userName:String) -> UIView {
        //投稿日時を追加する
        let postView = UIView()
        postView.backgroundColor = .systemBackground
        
        let PostText = UILabel()
        PostText.text = postText
        
        let UserId = UILabel()
        UserId.text = userId
        
        let button = UIButton(type: .system)
        button.setTitle("like", for: .normal)

        postView.addSubview(PostText)
        postView.addSubview(button)
        
        PostText.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postView.heightAnchor.constraint(equalToConstant: 100),
            
            PostText.topAnchor.constraint(equalTo: postView.topAnchor, constant: 8),
            PostText.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 8),
            
            button.topAnchor.constraint(equalTo: PostText.bottomAnchor, constant: 8),
            button.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 8)
        ])
        
        return postView
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
#Preview(){
    TimelineViewController()
}
