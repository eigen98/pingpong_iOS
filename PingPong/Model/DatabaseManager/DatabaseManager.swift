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
    
    
    
    /*
     유저 상태 확인
      0 : teacher , 1 : Student
     */
    
    public func checkRole(email : String,
                                completion : @escaping (Int) -> Void
    ){
        database.child("users").child(email).observeSingleEvent(of: .value, with: { snapshot in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let role = value?["role"] as? Int ?? 0
            
            completion(role)

            // ...
          }) { error in
            print(error.localizedDescription)
              completion(0)
          }
        
    }
    
    
    public func getClassList(idEmail : String, completion : @escaping ([Subject]) -> Void){
        
        database.child("subject").child(idEmail).observeSingleEvent(of : .value, with: { snapshot in
            //snapshot의 값을 딕셔너리 형태로 변경해줍니다.
            guard let snapData = snapshot.value as? [String:Any] else {return}
            //Data를 JSON형태로 변경해줍니다.
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            print("\(snapData.values)")
            print("\(data)")
                        
            let decoder = JSONDecoder()
            let singList = try decoder.decode([Sing].self, from: data)
            
        })
        
    }
}
