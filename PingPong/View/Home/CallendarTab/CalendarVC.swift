//
//  CalendarVC.swift
//  PingPong
//
//  Created by JeongMin Ko on 2022/08/22.
//

import Foundation
import UIKit
import FSCalendar
import RxSwift
import TimelineTableViewCell

//캘린더 탭
class CalendarVC : UIViewController{
    
    let disPoseBag = DisposeBag()
    let calendarContainer = UIView()
    var selected = ""
    
    let prevBtn = UIButton()
    let nextBtn = UIButton()
    
    var calendar = FSCalendar()
    let dateFormatter = DateFormatter()
    
    //플로팅 버튼 (클래스 추가.)
    let floatingBtn = UIButton()
    
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    
    
    var dateComponents : DateComponents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        
        calendar.delegate = self
        calendar.dataSource = self
        
        self.view.backgroundColor = .systemBackground
        settingCalendar()
        
        bind()
        
        setSwipeGesture()
    }
    
    func setSwipeGesture(){
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func layout(){
        
        self.view.layer.cornerRadius = 20
        self.view.addSubview(calendarContainer)
        calendarContainer.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(48)
           // $0.width.equalTo(view.snp.width)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        calendarContainer.addSubview(calendar)
        calendar.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        calendar.addSubview(prevBtn)
        calendar.addSubview(nextBtn)
        
        prevBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        nextBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        
        prevBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(60)
            $0.top.equalToSuperview().offset(16)
            $0.width.height.equalTo(20)
        }
        nextBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(18)
            $0.top.equalToSuperview().offset(16)
            $0.width.height.equalTo(20)
        }
        
        //플로팅 버튼 추가 (판매글 올리기)
        self.view.addSubview(floatingBtn)
        
        floatingBtn.snp.makeConstraints{
            $0.width.height.equalTo(48)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(72)
        }
        floatingBtn.setImage(UIImage(named: "add_class_floating_btn_img"), for: .normal)
        
        
    }
    
    
    //moveUp이 true라면 다음달, false라면 이전달로 현재 페이지를 옮겨

    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
            
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    func bind(){
        
        dateFormatter.dateFormat = "yyyy년 MM월 dd일" // 2022-07-13
        self.prevBtn.rx.tap
            .subscribe(onNext : {
                print(" pre ")
                self.scrollCurrentPage(isPrev: true)
            }).disposed(by: disPoseBag)
        
        self.nextBtn.rx.tap
            .subscribe(onNext : {
                self.scrollCurrentPage(isPrev: false)
                print(" next ")
            }).disposed(by: disPoseBag)
        
        
       
    }
    
    func settingCalendar(){
        self.dateComponents = DateComponents()
        //월화수목금토일 세팅
        calendar.locale = Locale(identifier: "ko_KR")
        
        // 헤더 폰트 설정
        calendar.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)

        // Weekday 폰트 설정
        calendar.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 10)
        calendar.appearance.weekdayTextColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)

        // 각각의 일(날짜) 폰트 설정 (ex. 1 2 3 4 5 6 ...)
        calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        
        self.calendar.appearance.borderRadius = 0
        
        
        // 헤더의 날짜 포맷 설정
        calendar.appearance.headerDateFormat = "YYYY년 MM월"

        // 헤더의 폰트 색상 설정
        calendar.appearance.headerTitleColor = .black
        
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 16, weight: .bold)

        // 헤더의 폰트 정렬 설정
        // .center & .left & .justified & .natural & .right
        calendar.appearance.headerTitleAlignment = .left
        

        // 헤더 높이 설정
        calendar.headerHeight = 60

        // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0   // 0.0 = 안보이게 됩니다.
        
        calendar.calendarHeaderView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(-56)
            $0.top.equalToSuperview().offset(16)
            $0.width.equalTo(280)
            $0.height.equalTo(20)
        }
        self.calendar.appearance.titleOffset = CGPoint(x: 0, y: 14)
        
    }
    /*
     스와이프 이벤트
     */
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {

        if swipe.direction == .up {
            calendar.scope = .week
        }
        else if swipe.direction == .down {
            calendar.scope = .month
        }
    }
}

extension CalendarVC : FSCalendarDelegate, FSCalendarDataSource{
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 날짜가 선택되었습니다.")
        selected = dateFormatter.string(from: date)
        //선택시 크기 변경
        self.calendar.scope = .week
    }
    
    //지난 날짜 비활성화
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if date .compare(Date()) == .orderedAscending {
            return false
        }
        else {
            return true
        }
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
       return Date()
    }
    //선택해제
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        //return false // 선택해제 불가능
        return true // 선택해제 가능
    }
    
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
        self.calendar.scope = .month
    }
    
    
}
