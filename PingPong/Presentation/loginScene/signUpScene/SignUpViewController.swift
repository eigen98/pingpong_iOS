//
//  SignUpViewController.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/18.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa


//회원가입 - 가입 유형 선택 레이아웃 (첫번째)
class SignUpViewController : UIViewController {
    
    
    let disposeBag = DisposeBag()
    let typePleaseLabel = UILabel()
    let teacherButton = UIButton()
    let studentButton = UIButton()
    
    let nextButton = UIButton()
    
//    let signUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(tapMoveBack(_:)))
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
//        bind(viewModel: signUpViewModel)
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(viewModel : SignUpViewModel){
        
        //UIBind
        teacherButton.rx.tap.asObservable()
            .withUnretained(self)
            .map{owner, str in
                owner.teacherButton.currentImage?.isEqual(UIImage(named: "teacher_activated")) ?? false
            }.bind(onNext: { [weak self] status in
                guard let self = self else{ return }
                viewModel.tapTypeButton(status)
                print("선생님 여부 : \(status)")
            }).disposed(by: disposeBag)
        
        //UIBind
        studentButton.rx.tap.asObservable()
            .withUnretained(self)
            .map{owner, str in
                owner.teacherButton.currentImage?.isEqual(UIImage(named: "teacher_activated")) ?? false
            }.bind(onNext: { [weak self] status in
                guard let self = self else{ return }
                viewModel.tapTypeButton(status)
            }).disposed(by: disposeBag)
        
        viewModel.typeOfUser.asDriver(onErrorJustReturn: false)
            .drive(onNext : { [weak self] status in
                guard let self = self else { return }
                self.tapTypeUIButton(status)
            }).disposed(by: disposeBag)
        
        //다음 버튼 이벤트
        nextButton.rx.tap.asObservable()
            .subscribe(onNext : {
                let signUpEmailVC = SignUpEmailViewController()
                signUpEmailVC.bind(viewModel: viewModel)
                self.navigationController?.pushViewController(signUpEmailVC, animated: true)
            })
    }
    
    func layout(){
        [typePleaseLabel, teacherButton, studentButton, nextButton].forEach{
            view.addSubview($0)
        }
        
        typePleaseLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(113)
            $0.leading.equalToSuperview().offset(16)
        }
        
        teacherButton.snp.makeConstraints{
            $0.top.equalTo(typePleaseLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(152)
            
        }
        studentButton.snp.makeConstraints{
            $0.top.equalTo(teacherButton.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(152)
            
        }
        nextButton.snp.makeConstraints{
            $0.bottom.trailing.leading.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    func attribute(){
        typePleaseLabel.text = "가입 유형을 선택해주세요"
        typePleaseLabel.font = .systemFont(ofSize: 16)
        
        teacherButton.setImage(UIImage(named: "teacher_disabled"), for: .normal)
        studentButton.setImage(UIImage(named: "student_disabled"), for: .normal)
        
        nextButton.setTitle( "다음", for: .normal)
        nextButton.backgroundColor = .blue
        nextButton.tintColor = .white
    }
    
    
    
    func tapTypeUIButton(_ typeOfUser : Bool){
        if typeOfUser {
            teacherButton.setImage(UIImage(named: "teacher_activated"), for: .normal)
            studentButton.setImage(UIImage(named: "student_disabled"), for: .normal)
        }else {
            teacherButton.setImage(UIImage(named: "teacher_disabled"), for: .normal)
            studentButton.setImage(UIImage(named: "student_activated"), for: .normal)
        }
    }
    
    
    @objc func tapMoveBack(_ : UIButton){
        navigationController?.popViewController(animated: true)
    }
    
}
