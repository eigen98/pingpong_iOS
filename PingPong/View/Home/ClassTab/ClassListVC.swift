//
//  ClassListVC.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/22.
//

import Foundation
import UIKit
//수업 목록
class ClassListVC : UIViewController {
 
    var classNumLabel = UILabel()
    var emptyViewContainer = UIView()
    var emptyImg = UIImageView()
    var createClassBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    func layout(){
        [classNumLabel, emptyViewContainer].forEach{
            self.view.addSubview($0)
        }
        classNumLabel.snp.makeConstraints{
            $0.trailing.top.equalToSuperview().inset(20)
        }
        
        emptyViewContainer.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.width.equalTo(192)
            $0.height.equalTo(219)
        }
        emptyViewContainer.addSubview(emptyImg)
        emptyImg.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(127)
            $0.height.equalTo(123)
        }
        
        emptyViewContainer.addSubview(createClassBtn)
        createClassBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emptyImg.snp.bottom).offset(16)
            $0.width.equalTo(106)
            $0.height.equalTo(32)
        }
        
        
        
        
        
    }
    func attribute(){
        classNumLabel.text = "0개"
        
        emptyImg.image = UIImage(named: "empty_class_img")
        createClassBtn.setImage(UIImage(named: "create_class_btn_img"), for: .normal)
    }
    
}
