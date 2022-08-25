//
//  ViewModelType.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/25.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}
