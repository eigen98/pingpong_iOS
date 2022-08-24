//
//  ClassListCell.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/23.
//

import Foundation
import UIKit
//수업 리스트 셀
class ClassListCell : UITableViewCell {
    
    var containerView = UIView()
    var profileImg = UIImageView()
    var nameLabel = UILabel()
    var subjectLabel = UILabel()
    var menuBtn = UIButton()
    
    // 요일 컴퍼넌트 Todo
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        layout()
        attribute()
    }
    
    func layout(){
        
        self.contentView.addSubview(containerView)
        
        [profileImg,nameLabel,subjectLabel, menuBtn].forEach{
            containerView.addSubview($0)
        }
        
        containerView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview()
            
        }
        
        profileImg.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(21)
            $0.width.height.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints{
            $0.leading.equalTo(profileImg.snp.trailing).offset(14)
            $0.top.equalTo(profileImg.snp.top).offset(4)
            
        }
        
        subjectLabel.snp.makeConstraints{
            $0.leading.equalTo(profileImg.snp.trailing).offset(14)
            $0.bottom.equalTo(profileImg.snp.bottom).offset(-4)
            
        }
        
        menuBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(14)
            $0.width.height.equalTo(16)
        }
        
        
        
    }
    
    func attribute(){
        profileImg.image = UIImage(named: "profile_img")
        
        nameLabel.text = "OOO"
        subjectLabel.text = "OO과목"
        
        menuBtn.setImage(UIImage(named: "menu_btn_img"), for: .normal)
        
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
