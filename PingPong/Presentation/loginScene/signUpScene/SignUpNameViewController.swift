//
//  SignUpNameViewController.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/19.
//

import Foundation
import UIKit
import FirebaseAuth

//회원가입 이름입력 (마지막)
class SignUpNameViewController : UIViewController {
    let pleaseNameLabel = UILabel()
    let nameTextField = UITextField()
    let nextButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 버튼 설정.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(tapMoveBack(_:)))
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func layout(){
        [pleaseNameLabel, nameTextField, nextButton].forEach{
            view.addSubview($0)
        }
        
        pleaseNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(113)
            $0.leading.equalToSuperview().inset(16)
        }
        
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(pleaseNameLabel.snp.bottom).offset(16)
            $0.height.equalTo(48)
        }
        nextButton.snp.makeConstraints{
            $0.bottom.trailing.leading.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    
    func attribute(){
        pleaseNameLabel.text = "이름을 입력해주세요"
        pleaseNameLabel.font = .systemFont(ofSize: 16)
        
        nameTextField.font = .systemFont(ofSize: 14)
        nameTextField.placeholder = "이름을 입력해주세요."
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 5
        nameTextField.addLeftPadding() //텍스트 마진값 설정(익스텐션 추가)
    
        nextButton.setTitle( "다음", for: .normal)
        nextButton.backgroundColor = .blue
        nextButton.tintColor = .white
    }
    func bind(viewModel : SignUpViewModel){
        
        //다음 버튼 이벤트
        nextButton.rx.tap.asObservable()
            .subscribe(onNext : {
                Auth.auth().signIn(withEmail: viewModel.email, password: viewModel.password, completion: { authResult, error in
                   
                    
                })
            })
    }
    
     
    
    
    @objc func tapMoveBack(_ : UIButton){
        navigationController?.popViewController(animated: true)
    }
}
