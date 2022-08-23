//
//  ClassListVC.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/22.
//

import Foundation
import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import Then

//수업 목록
class ClassListVC : UIViewController {
 
    
    var disposeBag: DisposeBag = DisposeBag()
    var classNumLabel = UILabel()
    var emptyViewContainer = UIView()
    var emptyImg = UIImageView()
    var createClassBtn = UIButton()

    var sectionSubject = BehaviorRelay(value: [SectionOfSubject]())
    
    let classTableView = UITableView().then {
        $0.register(ClassListCell.self, forCellReuseIdentifier: "ClassListCell")
        $0.register(CreateClassCell.self, forCellReuseIdentifier: "CreateClassCell")
        
        $0.backgroundColor = .white
        $0.rowHeight = 100
        
    }
    
    var dataSource = RxTableViewSectionedReloadDataSource<SectionOfSubject> { dataSource, tableView, indexPath, sectionItem in
        switch sectionItem {
        case .subject:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClassListCell", for: indexPath) as! ClassListCell
          return cell
            
        case .addOn:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateClassCell", for: indexPath) as! CreateClassCell
          
          return cell
        }
      }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    func layout(){
        [classNumLabel, emptyViewContainer, classTableView].forEach{
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
        classTableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
        
        
        
    }
    func attribute(){
        classNumLabel.text = "0개"
        
        emptyImg.image = UIImage(named: "empty_class_img")
        createClassBtn.setImage(UIImage(named: "create_class_btn_img"), for: .normal)
    }
    
    func bind(viewModel : ClassListViewModel){
        
        sectionSubject.accept(viewModel.data)
        sectionSubject
            .bind(to: self.classTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        classTableView.rx.itemSelected
           .subscribe(onNext: { [weak self] indexPath in
               guard let self = self else { return }
               let data = viewModel.data
               print("\(indexPath.row)번째 Cell: \(data[indexPath.row])")
           }).disposed(by: disposeBag)
    }
    
    

   
}


enum SectionOfSubject{
    case subject([SubjectItem])
    case addOn
}
enum SubjectItem{
    case subject
    case addOn
}

extension SectionOfSubject : SectionModelType{
    var items : [SubjectItem]{
        switch self{
        case .subject(let items) : return items
        case .addOn: return items
        }
    }
    
    init(original: SectionOfSubject, items: [SubjectItem]) {
        switch original {
        case .subject : self = .subject(items)
        case .addOn: self = .addOn
        }
    }
}
