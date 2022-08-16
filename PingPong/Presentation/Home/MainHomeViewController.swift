//
//  MainHomeViewController.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/05/26.
//

import Foundation
import UIKit
import ReactorKit

class MainHomeViewController : UIViewController, View{
    var disposeBag: DisposeBag = DisposeBag()
    
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func bind(reactor: MainHomeReactor) {
        
    }
    
    
}
