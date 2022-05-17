//
//  UITextField+.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/17.
//

import Foundation
import UIKit


extension UITextField {
    
    //텍스트 입력 마진값 추가
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
