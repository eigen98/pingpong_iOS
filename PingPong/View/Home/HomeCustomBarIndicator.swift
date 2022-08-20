//
//  CustomBarIndicator.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/20.
//

import Foundation
import UIKit
import Tabman
// 커스텀 탭바 인디케이터
class HomeCustomBarIndicator: TMBarIndicator {
    
    
    var customView = UIView()
    
    override func layoutSubviews() {
        layout(in: customView)
        self.overscrollBehavior = .compress
        self.transitionStyle = .snap
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout(in: customView)
    }
    
    override func layout(in view: UIView) {
        super.layout(in: view)

        // Create your indicator in `view`.
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        self.overscrollBehavior = .compress
        self.transitionStyle = .snap
        
    }
}
