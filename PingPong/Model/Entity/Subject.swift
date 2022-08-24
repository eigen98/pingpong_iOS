//
//  Subject.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/23.
//

import Foundation
import RxSwift
import RxDataSources

//과목
struct Subject : Codable {
    var id : String
    var subjectName : String
    var salary : Int
    var monthlyCnt : String //정산일
    var classTime : String
    var classDay : Int // (bit)
    var teacherId : String
    var teacherName : String
    var studentId : String
    var studentName : String
}



