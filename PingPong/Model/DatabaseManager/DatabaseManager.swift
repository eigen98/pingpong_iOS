//
//  DatabaseManager.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/16.
//

import Foundation
import FirebaseDatabase
final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //파이어베이스 db에서 키값으로 특수문자를 사용할 수 없는 문제 해결.
    static func convertEmail(email: String) -> String {
        var enableEmail = email.replacingOccurrences(of: "@", with: "-")
        enableEmail = enableEmail.replacingOccurrences(of: ".", with: "-")
        
        return enableEmail
    }
    
}

//
extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping ((Bool)-> Void)) {
        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
            
        }
    }
    
    
    // 유저 정보 DB에 업데이트
    public func updateUser(with user: User, completion: @escaping(Bool) -> Void) {
        database.child("users").child(user.emailKey).setValue([
            "id" : user.id,
            "email" : user.email,
            "userName" : user.userName,
            "role" : user.role, //0 : teacher , 1 : Student
            "phoneNumber" : user.phoneNumber
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
                print("failed to insert user to database")
                completion(false)
                return
            }

//            self.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
//                if var usersCollection = snapshot.value as? [[String: String]] {
//
//                    // append to user dictionary
//                    let newElement = [
//                        "name": user.firstName + " " + user.lastName,
//                        "email": user.safeEmail
//                    ]
//
//                    usersCollection.append(newElement)
//
//                    self.database.child("users").setValue(usersCollection, withCompletionBlock: { error, _ in
//                        guard error == nil else {
//                            completion(false)
//                            return
//                        }
//
//                        completion(true)
//                    })
//
//                } else {
//
//                    // create array
//                    let newCollection: [[String: String]] = [
//                        [
//                            "name": user.firstName + " " + user.lastName,
//                            "email": user.safeEmail
//                        ]
//                    ]
//
//                    self.database.child("users").setValue(newCollection, withCompletionBlock: { error, _ in
//                        guard error == nil else {
//                            completion(false)
//                            return
//                        }
//
//                        completion(true)
//                    })
//                }
//            })
            print("success ")
            completion(true)
        })
    }
}
