//
//  AuthViewModel.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class AuthViewModel {
    
    func createNewUser(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, err in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let firebaseUser = result?.user else { return }
            
            firebaseUser.sendEmailVerification { error in
                if let error = error {
                    print("DEBUG: Email verification failed to send: \(error.localizedDescription)")
                } else {
                    print("DEBUG: Verification email sent successfully.")
                }
            }

            let changeRequest = firebaseUser.createProfileChangeRequest()
            changeRequest.displayName = user.username
            changeRequest.commitChanges { _ in
                self?.setUserData(user: user, userID: firebaseUser.uid) { success in
                    completion(.success(success))
                }
            }
        }
    }
    
    private func setUserData(user: User, userID: String, completion: @escaping (Bool) -> Void) {
        Firestore.firestore()
            .collection("users")
            .document(userID)
            .setData([
                "name": user.username,
                "email": user.email,
                "uid": userID
            ]) { error in
                if let error = error {
                    print("Firestore Error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                completion(.failure(err))
                return
            }
            completion(.success(true))
        }
    }
}
