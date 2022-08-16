//
//  SignUpViewModel.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/18.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa



class SignUpViewModel{
    
    //true = 선생님, false = 학생
    let typeOfUser = PublishRelay<Bool>() //view -> ViewModel
    //0 : teacher , 1 : Student
    
    var email  = ""
    var password = ""
    var userName = ""
    var role = 0
    var emailKey = ""
    
    
    //가입유형 버튼 이벤트 변경
    func tapTypeButton(_ status : Bool){
        if status {
            typeOfUser.accept(false)
            role = 1
        }else {
            typeOfUser.accept(true)
            role = 0
        }
    }
    
}
