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
    
    let signUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind(viewModel: signUpViewModel)
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
                owner.teacherButton.isEqual(UIImage(named: "teacher_disabled")) ?? false
            }.bind(onNext: { [weak self] status in
                guard let self = self else{ return }
                viewModel.tapTypeButton(status)
            }).disposed(by: disposeBag)
        
        viewModel.typeOfUser.asDriver(onErrorJustReturn: false){
            
        }
    }
    
    func layout(){
        [typePleaseLabel, teacherButton, studentButton].forEach{
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
    }
    func attribute(){
        typePleaseLabel.text = "가입 유형을 선택해주세요"
        typePleaseLabel.font = .systemFont(ofSize: 16)
        
        teacherButton.setImage(UIImage(named: "teacher_disabled"), for: .normal)
        studentButton.setImage(UIImage(named: "student_disabled"), for: .normal)
        
        
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
    
    
}
