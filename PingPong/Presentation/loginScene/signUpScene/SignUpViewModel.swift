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
    
    
    func tapTypeButton(_ status : Bool){
        if status {
            typeOfUser.accept(false)
        }else {
            typeOfUser.accept(true)
        }
    }
    
}
