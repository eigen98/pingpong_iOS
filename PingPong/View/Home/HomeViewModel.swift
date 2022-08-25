//
//  HomeViewModel.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/20.
//

import Foundation
// 홈화면 뷰모델
class HomeViewModel : ViewModelType {
    var input: User = User(from: nil)
    
    var output: User = User(from: nil)
    
    typealias Input = User
    
    typealias Output = User
    
    
    
    func bind(vc : HomeVC){
        
    }
    
}
