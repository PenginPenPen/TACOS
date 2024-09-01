//
//  LoginManager.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/09/01.
//

import Foundation
import FirebaseAuth
import FirebaseCore
class LoginManager {
    static let shared = LoginManager()    
    var isLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            }
        }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
}
