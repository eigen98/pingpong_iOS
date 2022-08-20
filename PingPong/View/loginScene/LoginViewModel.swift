//
//  LoginViewModel.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/16.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit



struct LoginViewModel{
    
    
    var disposeBag = DisposeBag()
    //로그인 상태 유지 체크박스 옵저버블
    let autoLoginCheck = BehaviorRelay<Bool>(value: false)
    
    
    func isCheckedBox(_ status : Bool){
        if status {
            autoLoginCheck.accept(true)
        } else {
            autoLoginCheck.accept(false)
        }
    }

    
    
    
}
