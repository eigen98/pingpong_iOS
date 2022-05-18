//
//  LoginViewController.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/16.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import SnapKit
import SwiftUI
import GameKit

class LoginViewController : UIViewController {
    
    let disposeBag = DisposeBag()
    //로고 뷰
    let logoImage = UIImageView()//UIImage(named: "logo")
    let logoTextImage = UIImageView()//UIImage(named: "logoText")
    //이메일, 패스워드 텍스트
    let emailTextField = UITextField()
    let pwTextField = UITextField()
    
    //로그인 버튼, 로그인상태 유지 체크박스 버튼
    let loginButton = UIButton()
    let checkbox = UIButton()
    let checkTitle = UILabel()
    
    //비밀번호 숨기기 버튼
    let pwShowButtn = UIButton()
    
    //비밀번호 찾기, 회원가입 버튼
   
    let signUpButton = UIButton()
    let findPwButton = UIButton()
    let separator = UIView()
    var stackView : UIStackView = UIStackView()
    
    let validation = Validation()
    
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bind(viewModel : LoginViewModel){
        
        //이메일 입력 이벤트를 Validation의 Relay로 바인딩.
        emailTextField.rx.text.orEmpty
            .bind(to: validation.emailText)
            .disposed(by: disposeBag)
        
        pwTextField.rx.text.orEmpty
            .bind(to: validation.passwordText)
            .disposed(by: disposeBag)
        //비밀번호 숨기기 버튼
        pwShowButtn.rx.tap
            .asObservable()
            .withUnretained(self)
            .map{owner, str in
                owner.pwShowButtn.currentImage?
                    .isEqual(UIImage(systemName: "eye")) ?? false
            }.bind( onNext : { [weak self] status in
                guard let self = self else{ return }
                self.validation.checkEyeOn(status)
            })
        
        validation.isEyeOn.asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] eyeStatus in
                guard let self = self else { return }
                self.didTapPasswordEyeButton(eyeStatus)
            })
            .disposed(by: disposeBag)
        
        
        
        //로그인 상태 유지 버튼
        checkbox.rx.tap.asObservable()
            .withUnretained(self)
            .map{ owner, str in
                owner.checkbox.currentImage?.isEqual(UIImage(systemName: "rectangle")) ?? false
            }.bind(onNext: { [weak self] Status in
                guard let self = self else{ return }
                viewModel.isCheckedBox(Status)
            }).disposed(by: disposeBag)
        
        viewModel.autoLoginCheck.asDriver(onErrorJustReturn: false)
            .drive(onNext : { [weak self] status in
                guard let self = self else { return }
                self.didCheckAutoLoginBox(status)
            }).disposed(by: disposeBag)
        
        //회원가입 버튼 클릭 이벤트
        signUpButton.rx.tap.asObservable()
            .subscribe(onNext : {
                let signUpViewController = SignUpViewController()
                self.navigationController?.pushViewController(signUpViewController, animated: true)
            })
        
        
        let emailValidObservable = validation.isEmailVaild
            .asObservable()
            .share()
            .asDriver(onErrorJustReturn: false)
            .drive( onNext : {result in
                print("이메일 형식이 맞나요? \(result)")
            }).disposed(by: disposeBag)
        
        let passwordValidObservable = validation.isPasswordValid
            .asObservable()
            .share()
            .asDriver(onErrorJustReturn: false)
            .drive( onNext : { result in
                print("비밀번호 형식 맞나요? \(result)")
            }).disposed(by: disposeBag)
        
        
        Observable.combineLatest(validation.isEmailVaild, validation.isPasswordValid){
         $0 && $1
        }.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
                
        
        loginButton.rx.tap.asSignal().emit(onNext : {
            print("로그인 요청 보냄")
        })
        
        
        
        //
        
    }
    
    //컴포넌트 레이아웃 그려내기
    private func layout(){
        [logoImage, logoTextImage,
         emailTextField, pwTextField, pwShowButtn,
         loginButton, checkbox,checkTitle,
         stackView].forEach{
        
            view.addSubview($0)
        }
        
        logoImage.snp.makeConstraints{
            $0.height.equalTo(27)
            $0.width.equalTo(32)
            $0.top.equalToSuperview().inset(70)
            $0.centerX.equalToSuperview()
        }
        logoTextImage.snp.makeConstraints{
            $0.height.equalTo(23)
            $0.width.equalTo(120)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImage.snp.bottom).offset(16)
        }
        
        pwShowButtn.snp.makeConstraints{
            $0.width.equalTo(16)
            $0.height.equalTo(12)
            $0.trailing.equalTo(pwTextField.snp.trailing).inset(16)
            $0.centerY.equalTo(pwTextField.snp.centerY)
        }
        
        emailTextField.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(logoTextImage.snp.bottom).offset(42)
            $0.height.equalTo(48)
            
        }
        pwTextField.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(emailTextField.snp.bottom).offset(16)
            $0.height.equalTo(48)
        }
        
        loginButton.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(pwTextField.snp.bottom).offset(16)
            $0.height.equalTo(56)
        }
        
        checkbox.snp.makeConstraints{
            $0.height.width.equalTo(16)
            $0.top.equalTo(loginButton.snp.bottom).offset(16)
            $0.leading.equalTo(loginButton.snp.leading)
        }
        
        checkTitle.snp.makeConstraints{
            $0.leading.equalTo(checkbox.snp.trailing).offset(8)
            $0.top.equalTo(checkbox.snp.top)
            $0.bottom.equalTo(checkbox.snp.bottom)
            
        }
        
        
        separator.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(10)
        }
        signUpButton.snp.makeConstraints{
            $0.width.equalTo(findPwButton.snp.width)
            //$0.height.equalTo(18)

        }
//        findPwButton.snp.makeConstraints{
//            $0.width.equalTo(30)
//            $0.height.equalTo(18)
//
//        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(checkTitle.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(8)
        }
        
        
        
        
    }
    
    //컴포넌트 속성 설정
    private func attribute(){
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 5
        emailTextField.placeholder = "이메일을 입력해주세요"
        emailTextField.font = .systemFont(ofSize: 14)
        emailTextField.addLeftPadding() //텍스트 마진값 설정 (익스텐션 추가)
        
        pwTextField.layer.borderWidth = 1
        pwTextField.layer.cornerRadius = 5
        pwTextField.placeholder = "비밀번호를 입력해주세요"
        pwTextField.font = .systemFont(ofSize: 14)
        pwTextField.isSecureTextEntry = true
        pwTextField.addLeftPadding() //텍스트 마진값 설정 (익스텐션 추가)
        
        pwShowButtn.setImage(UIImage(systemName: "eye"), for: .normal) //eye.slash
        pwShowButtn.tintColor = .gray
        
        logoImage.image = UIImage(named: "logo")
        logoTextImage.image = UIImage(named: "logoText")
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.textColor = .white
        loginButton.backgroundColor = .blue
        loginButton.isEnabled = false
        
        //체크박스
        checkbox.setImage(UIImage(systemName: "rectangle"), for: .normal)
        checkbox.tintColor = .gray
        
        checkTitle.text = "로그인 상태를 유지할게요"
        checkTitle.textColor = .label
        checkTitle.font = .systemFont(ofSize: 14)
        
        //비밀번호찾기 버튼 텍스트
        findPwButton.setTitle("비밀번호 찾기", for: .normal)
        findPwButton.setTitleColor(.gray, for: .normal)
        findPwButton.titleLabel?.font = .systemFont(ofSize: 12)
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.gray, for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 12)
        separator.backgroundColor = .separator
        
        stackView = UIStackView(arrangedSubviews: [signUpButton, separator,findPwButton ])
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
        
    }
    
    
    
    func didTapPasswordEyeButton(_ isEyeOn: Bool) {
        if isEyeOn {
            pwShowButtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            pwTextField.isSecureTextEntry = true
        } else {
            pwShowButtn.setImage(UIImage(systemName: "eye"), for: .normal)
            pwTextField.isSecureTextEntry = false
        }
    }
    //체크박스 클릭 이벤트 메소드
    func didCheckAutoLoginBox(_ ischecked : Bool){
        if ischecked {
            checkbox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }else {
            checkbox.setImage(UIImage(systemName: "rectangle"), for: .normal)
        }
    }
}
