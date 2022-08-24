//
//  CreateClassCell.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/23.
//

import Foundation
import UIKit
class CreateClassCell : UITableViewCell {
    
    var containerView = UIView()
    var plusImg = UIImageView()
    var createLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        attribute()
    }
    
    func layout(){
        self.contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview()
            
        }
        
        containerView.addSubview(plusImg)
        containerView.addSubview(createLabel)
        
        plusImg.snp.makeConstraints{
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(28)
            $0.centerX.equalToSuperview()
        }
        
        createLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(plusImg.snp.bottom).offset(4)
            
        }
        
    }
    
    func attribute(){
        plusImg.image = UIImage(named: "plus_img")
        createLabel.text = "클래스 만들기"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
