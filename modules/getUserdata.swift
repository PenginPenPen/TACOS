//
//  getUserdata.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/09/02.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
let db = Firestore.firestore()
func getUserdata(){
    if LoginManager.shared.isLoggedIn {
        let uid = Auth.auth().currentUser?.uid
        let userRef = db.collection("Users").document(uid!)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                data
                return()
            } else {
                print("データがありません。")
            }
        }
    } else {
        print("ログインしてません")
    }
}
