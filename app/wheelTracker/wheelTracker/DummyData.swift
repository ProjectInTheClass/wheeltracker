//
//  DummyData.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/05/06.
//

import Foundation
import CoreLocation

var height: Int = 177
var weight: Int = 70
var name: String = "이충수"
var age: Int = 68
var wheelSize: Double = 0.58

var nowLocation: CLLocation?

let distanceEvent = EventManager()

// date용 함수들
extension Date {
    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }
    
    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }
    
    var isInThisYear:  Bool { isInSameYear(as: Date()) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    var isInThisWeek:  Bool { isInSameWeek(as: Date()) }
    
    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }
    
    var isInTheFuture: Bool { self > Date() }
    var isInThePast:   Bool { self < Date() }
}


struct PushData {
    var createdAt: Date
    var distance: Double
    
    var x1: Double?
    var x2: Double?
    var y1: Double?
    var y2: Double?
    
    var duration: TimeInterval
    var pushCount: Int{
        return Int(distance / (wheelSize * 6.28))
    }
    var calorie: Double{
        return distance * 0.075
    }
    
    static func +=(lhs: inout PushData, rhs: PushData) {
        lhs.distance += rhs.distance
        lhs.duration += rhs.duration
    }
    
}


var pushDatas = [
    PushData(createdAt : Date(), distance : 1800, duration : 60*15)
]


public func initPushDatas(){
    for i in 1...24*30{
        pushDatas.append(PushData(createdAt: Date(timeIntervalSinceNow: -86400 * Double(i)), distance: 1000*5*Double(Int.random(in: 1...10)), duration: 60 * 30*Double(Int.random(in: 1...10))))
    }
    pushDatas = pushDatas.reversed()
}
