//
//  MainHomeReactor.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/26.
//

import Foundation
import ReactorKit
import UIKit

class MainHomeReactor : Reactor{
    
    
    enum Action {
        case touchButton(index: Int)
    }
    
    enum Mutation {
        case setImage(image: UIImage?)
    }
    
    struct State {
        var image: UIImage?
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
}
