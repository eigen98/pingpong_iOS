//
//  SignUpEmailViewController.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/19.
//

import Foundation
import UIKit
//이메일 입력 뷰(두번째)
class SignUpEmailViewController : UIViewController{
    

    let pleaseEmailLabel = UILabel()
    let emailTextField = UITextField()
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
        [pleaseEmailLabel, emailTextField, nextButton].forEach{
            view.addSubview($0)
        }
        
        pleaseEmailLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(113)
            $0.leading.equalToSuperview().inset(16)
        }
        
        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(pleaseEmailLabel.snp.bottom).offset(16)
            $0.height.equalTo(48)
        }
        nextButton.snp.makeConstraints{
            $0.bottom.trailing.leading.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    
    func attribute(){
        pleaseEmailLabel.text = "이메일을 입력해주세요"
        pleaseEmailLabel.font = .systemFont(ofSize: 16)
        
        emailTextField.font = .systemFont(ofSize: 14)
        emailTextField.placeholder = "이메일을 입력해주세요."
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 5
        emailTextField.addLeftPadding() //텍스트 마진값 설정(익스텐션 추가)
    
        nextButton.setTitle( "다음", for: .normal)
        nextButton.backgroundColor = .blue
        nextButton.tintColor = .white
    }
    func bind(viewModel : SignUpViewModel){
        
        //다음 버튼 이벤트
        nextButton.rx.tap.asObservable()
            .subscribe(onNext : {
                let signUpPasswordViewController = SignUpPasswordViewController()
                signUpPasswordViewController.bind(viewModel: viewModel)
                self.navigationController?.pushViewController(signUpPasswordViewController, animated: true)
            })
        
        
        emailTextField.rx.text
            .asObservable()
    }
    
    
    
    
    @objc func tapMoveBack(_ : UIButton){
        navigationController?.popViewController(animated: true)
    }
}
