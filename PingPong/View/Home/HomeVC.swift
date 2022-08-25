//
//  HomeVC.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/20.
//

import Foundation
import UIKit
import Tabman
import FirebaseAuth

//홈화면
class HomeVC : UIViewController {
    
    var logoImg = UIImageView()
    var settingBtn = UIButton()
    var greetLabel = UILabel()
    var statusClassLabel = UILabel()
    
    var tabbarContainer = UIView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        attribute()
        let user = Auth.auth().currentUser
        let useremail = user!.email!
        let convertedEmail = DatabaseManager.convertEmail(email: useremail)
        
        DatabaseManager.shared.getClassList(idEmail: convertedEmail, completion: {result in
            print("getClass result : \(result)")
            
        })
    }
    
    func layout(){
        self.view.addSubview(logoImg)
        logoImg.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalTo(88)
            $0.height.equalTo(17)
        }
        
        self.view.addSubview(settingBtn)
        settingBtn.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        
        [greetLabel, statusClassLabel, tabbarContainer].forEach{
            self.view.addSubview($0)
        }
        greetLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(logoImg.snp.bottom).offset(28)
        }
        statusClassLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(greetLabel.snp.bottom).offset(8)
        }
        tabbarContainer.snp.makeConstraints{
            $0.top.equalTo(statusClassLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        setTabmanVC()
        
    }
    
    func attribute(){
        
        logoImg.image = UIImage(named: "home_logo_img")
        settingBtn.setImage(UIImage(named: "setting_btn_img"), for: .normal)
        greetLabel.text = "OOO님, 안녕하세요!"
        statusClassLabel.text = "오늘은 수업이 없는 날이네요!"
        
        
        
    }
    /*
     탭바 넣기
     */
    func setTabmanVC(){
        var tabmanController = TabmanController()
        self.addChild(tabmanController)
        tabmanController.view.frame = self.tabbarContainer.frame
        tabbarContainer.addSubview(tabmanController.view)
    }
    
    
}
