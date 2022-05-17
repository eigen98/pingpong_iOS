//
//  Validation.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/17.
//

import Foundation
import RxSwift
import RxCocoa

class Validation {
    
    let disposeBag = DisposeBag()
    
    let emailText = BehaviorRelay(value: "")
    let passwordText = BehaviorRelay(value: "")
    let isEmailVaild = BehaviorRelay(value: false)
    let isPasswordValid = BehaviorRelay(value: false)
    let eyeOnOff = BehaviorRelay(value: false)
    let isEyeOn = PublishRelay<Bool>()
    
    init(){
        print("validation 초기화")
        emailText.distinctUntilChanged()
            .withUnretained(self)
            .map { owner, str in
                print("validation : \(str)")
                return owner.checkEmailVaild(str)
                
            }
            .bind(to: isEmailVaild)
            .disposed(by: disposeBag)
        
        passwordText.distinctUntilChanged()
            .withUnretained(self)
            .map { owner, str in
                owner.checkPasswordVaild(str)
            }
            .bind(to: isPasswordValid)
            .disposed(by: disposeBag)
    }
    
    
    //이메일 유효성 체크
    private func checkEmailVaild(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    //비밀번호 유효성 체크
    private func checkPasswordVaild(_ password: String) -> Bool {
        return password.count >= 8
    }

    // 비밀번호 보이기 버튼
    func checkEyeOn(_ eyeStatus: Bool) {
        if eyeStatus {
            isEyeOn.accept(true)
        }
        else {
            isEyeOn.accept(false)
        }
    }
}
