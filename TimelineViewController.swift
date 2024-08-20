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
    override func viewDidLoad(){
        super.viewDidLoad()
        setupView()
        Task {
            do {
                let _: () =  await getData()
            }
        }
        // Do any additional setup after loading the view.
    }
    private func setupView(){
        self.title="タイムライン"
        view.backgroundColor =  UIColor(red: 0.98, green: 1.00, blue: 0.25, alpha: 1.0)
    }
    private func getData() async{
        let docRef = db.collection("TestData").document("TestPost")
        
        do {
          let document = try await docRef.getDocument()
          if document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
          } else {
            print("Document does not exist")
          }
        } catch {
          print("Error getting document: \(error)")
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
#Preview(){
    TimelineViewController()
}
