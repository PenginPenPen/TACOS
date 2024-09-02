//
//  Savecoin.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/09/02.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
func SaveCoin(coin:Int){
    let db = Firestore.firestore()
    _ = Auth.auth().addStateDidChangeListener { (auth, user) in
        if let user = user {
            let userRef = db.collection("Users").document(user.uid)
            userRef.setData([
                "totalCoin":coin
            ]) { err in
                if let err = err {
                    print("Error: \(err)")
                } else {
                    print("User data saved successfully!\(coin)")
                }
            }
        }
    }
}
