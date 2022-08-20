//
//  TabmanController.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/20.
//

import Tabman
import Pageboy
import Foundation
import UIKit

class TabmanController : TabmanViewController{
    
    private var viewControllers: Array<UIViewController> = []
    var tabBtnView = UIView()
    var tabBackgroundView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        let classListVC = UIViewController()
        let callendarVC = UIViewController()
        
        viewControllers.append(classListVC)
        viewControllers.append(callendarVC)
        
        dataSource = self
        let allCustomBar = TMBarView< TMHorizontalBarLayout , TMLabelBarButton , HomeCustomBarIndicator>()
    
        let bar =  allCustomBar // TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.indicator.overscrollBehavior = .compress
        bar.indicator.transitionStyle = .snap
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .custom(view: tabBtnView, layout: nil))
        
    }
    
    func layout(){
        
        self.view.addSubview(self.tabBtnView)
        tabBtnView.snp.makeConstraints{
            $0.leading.top.equalToSuperview().inset(16)
            $0.width.equalTo(145)
            $0.height.equalTo(36)
        }
        
        tabBackgroundView.snp.makeConstraints{
            $0.width.equalTo(145)
            $0.height.equalTo(36)
        }
        
        
        tabBackgroundView.layer.cornerRadius = 20
        tabBackgroundView.layer.borderWidth = 1
        tabBackgroundView.layer.borderColor = UIColor(red: 0.269, green: 0.36, blue: 0.837, alpha: 1).cgColor
        
    }
    
}
extension TabmanController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func settingTabBar (ctBar : TMBarView<TMHorizontalBarLayout, TMLabelBarButton , HomeCustomBarIndicator>) {
      
        
        ctBar.layout.transitionStyle = .none
//        ctBar.snp.makeConstraints{
//            $0.width.equalTo(height/2)
//        }
        // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
        
        // 간격
        ctBar.spacing = 16
        // background 스타일
        ctBar.backgroundView.style = .custom(view: tabBackgroundView) //.flat(color: .white)
        
        // 선택 / 안선택 색 + font size
        ctBar.buttons.customize { (button) in
            button.tintColor = .gray
           // button.selectedTintColor = .black
           // button.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
           // button.selectedFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
        
        // 인디케이터 (아래 바 부분)
        
       // ctBar.indicator.weight = .custom(value: 2)
        ctBar.indicator.tintColor = .blue
//        ctBar.indicator.snp.makeConstraints{
//            $0.width.equalTo(height/2)
//
//        }   //탭바 길이
  
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
//        let item = TMBarItem(title: "")
//        item.title = "Page \(index)"
//        item.image = UIImage(named: "image.png")
//
//        return item
        
        // MARK: - Tab 안 글씨들
        switch index {
        case 0:
            return TMBarItem(title: "클래스")
        case 1:
            return TMBarItem(title: "캘린더")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }

    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    
}
