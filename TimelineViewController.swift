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
    private let postStackView = UIStackView()
    private let postView = UIView()
    override func viewDidLoad(){
        super.viewDidLoad()
        setupView()
        Task {
            do {
                let _: () =  await getData()
            }
        }
        setupStackView()
//        setupPostView()
        setupConstraints()
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
                print("Error fetching documents: \(error)")
                return // エラー発生時は処理を中断
            }

            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return // ドキュメントが見つからない場合は処理を中断
            }

            for document in documents {
                // ドキュメントのデータを取得
                guard let data = document.data() as? [String: Any] else {
                    print("Error accessing document data")
                    continue // 次のドキュメントへ
                }

                let date = data["date"] as? Timestamp
                let text = data["text"] as? String
                let userid = data["userId"] as? String
                let username = data["username"] as? String
                
                print(date,text,userid,username)
            }
        }
        
    }
    private func setupStackView(){
        postStackView.axis = .vertical
        postStackView.spacing = 20
        postStackView.distribution = .fill
//        formStackView.alignment = .center
        view.addSubview(postStackView)
    }
    private func setupConstraints() {
        postStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            postStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
//    private func setupPostView(){
//
//    }
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
