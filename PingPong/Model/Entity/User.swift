//
//  User.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/16.
//

import Foundation
struct User  : Codable{
    let id : String
    let email : String
    let emailKey : String
    let userName : String
   
    let role : Int // 0 : teacher , 1 : Student
    let phoneNumber : String
}
