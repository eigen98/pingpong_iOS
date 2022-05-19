//
//  SignUpPasswordViewController.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/19.
//

import Foundation
import UIKit

class SignUpPasswordViewController : UIViewController {
    
    let pleasePwLabel = UILabel()
    let pwTextField = UITextField()
    let nextButton = UIButton()
    
    //비밀번호 숨기기 버튼
    let pwShowButtn = UIButton()
    
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
        [pleasePwLabel, pwTextField, nextButton, pwShowButtn].forEach{
            view.addSubview($0)
        }
        
        pleasePwLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(113)
            $0.leading.equalToSuperview().inset(16)
        }
        
        pwTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(pleasePwLabel.snp.bottom).offset(16)
            $0.height.equalTo(48)
        }
        nextButton.snp.makeConstraints{
            $0.bottom.trailing.leading.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        pwShowButtn.snp.makeConstraints{
            $0.width.equalTo(16)
            $0.height.equalTo(12)
            $0.trailing.equalTo(pwTextField.snp.trailing).inset(16)
            $0.centerY.equalTo(pwTextField.snp.centerY)
        }
        
    }
    
    func attribute(){
        pleasePwLabel.text = "비밀번호를 입력해주세요"
        pleasePwLabel.font = .systemFont(ofSize: 16)
        
        pwTextField.font = .systemFont(ofSize: 14)
        pwTextField.placeholder = "비밀번호를 입력해주세요."
        pwTextField.layer.borderWidth = 1
        pwTextField.layer.cornerRadius = 5
        pwTextField.addLeftPadding() //텍스트 마진값 설정(익스텐션 추가)
    
        nextButton.setTitle( "다음", for: .normal)
        nextButton.backgroundColor = .blue
        nextButton.tintColor = .white
        
        pwShowButtn.setImage(UIImage(systemName: "eye"), for: .normal) //eye.slash
        pwShowButtn.tintColor = .gray
        
    }
    func bind(viewModel : SignUpViewModel){
        
        //다음 버튼 이벤트
        nextButton.rx.tap.asObservable()
            .subscribe(onNext : {
                let signUpNameViewController = SignUpNameViewController()
                signUpNameViewController.bind(viewModel: viewModel)
                self.navigationController?.pushViewController(signUpNameViewController, animated: true)
            })
    }
    
    
    
    
    @objc func tapMoveBack(_ : UIButton){
        navigationController?.popViewController(animated: true)
    }
}
