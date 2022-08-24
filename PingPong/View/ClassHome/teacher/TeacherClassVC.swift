//
//  TeacherClassVC.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/22.
//

import Foundation
import UIKit
import TimelineTableViewCell
import RxDataSources
// 클래스홈
class TeacherClassVC : UIViewController{
    
    let backBtn = UIButton()
    let titleLabel = UILabel()
    let descriptionBackView = UIImageView()
    let menuBtn = UIButton()
    
    let profileImg = UIImageView()
    let inviteBtn = UIButton()
    let descriptionLabel = UILabel()
    
    let containerEmpty = UIView()
    let emptyImg = UIImageView()
    let emptyLabel = UILabel()
    
    let timeLineTableView = UITableView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        attribute()
        
//        // 테이블뷰 셀 설정.
//        let bundle = Bundle(for: TimelineTableViewCell.self)
//        let nibUrl = bundle.url(forResource: "TimelineTableViewCell", withExtension: "bundle")
//        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell",
//            bundle: Bundle(url: nibUrl)!)
//        timeLineTableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
    
    }
    
    func layout(){
        
        [backBtn,
         titleLabel,
         menuBtn,
         profileImg,
         inviteBtn,
         descriptionBackView,
         descriptionLabel,
         containerEmpty,
         timeLineTableView
         
         
        ].forEach{
            self.view.addSubview($0)
        }
        containerEmpty.addSubview(emptyImg)
        containerEmpty.addSubview(emptyLabel)
        
        
        backBtn.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backBtn.snp.centerY)
        }
        
        
        menuBtn.snp.makeConstraints{
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(13)
            $0.width.height.equalTo(30)
        }
        
        profileImg.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(64)
        }
        
        inviteBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImg.snp.bottom).offset(8)
            $0.width.equalTo(70)
            $0.height.equalTo(32)
        }
        
        
//        descriptionBackView.snp.makeConstraints{
//            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.top.equalTo(inviteBtn.snp.bottom).offset(32)
//            $0.height.equalTo(44)
//        }
        descriptionLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(inviteBtn.snp.bottom).offset(32)
            $0.height.equalTo(44)
        }
        
        containerEmpty.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(100)
            $0.height.equalTo(157)
        
        }
        
        emptyImg.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(130)
            $0.height.equalTo(109)
        }
        emptyLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emptyImg.snp.bottom).offset(16)
        }
        
        timeLineTableView.snp.makeConstraints{
            $0.top.equalTo(inviteBtn.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
         
    }
    
    func attribute(){
        titleLabel.text = "OOO"
        
        
        backBtn.setImage(UIImage(named: "back_btn_img"), for: .normal)
        menuBtn.setImage(UIImage(named: "menu_btn_img"), for: .normal)
        
        profileImg.image = UIImage(named: "profile_img")
        
        inviteBtn.setImage(UIImage(named: "invite_btn_img"), for: .normal)
        
        descriptionLabel.text = "OOO 학생의 수업 진도를 확인할 수 있어요."
       // descriptionBackView.image = UIImage(named: "description_img")
        descriptionLabel.layer.shadowPath = UIBezierPath(roundedRect: descriptionBackView.bounds, cornerRadius: 10).cgPath
        descriptionLabel.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        
        emptyImg.image = UIImage(named: "empty_class_home_img")
        emptyLabel.text = "수업을 시작해보세요!"
        
        
        
    }
}


//enum SectionTimeLine{
//    case subject([SubjectItem])
//    case addOn
//}
//enum SubjectItem{
//    case subject
//    case addOn
//}
//
//extension SectionOfSubject : SectionModelType{
//    var items : [SubjectItem]{
//        switch self{
//        case .subject(let items) : return items
//        case .addOn: return items
//        }
//    }
//    
//    init(original: SectionOfSubject, items: [SubjectItem]) {
//        switch original {
//        case .subject : self = .subject(items)
//        case .addOn: self = .addOn
//        }
//    }
//}
