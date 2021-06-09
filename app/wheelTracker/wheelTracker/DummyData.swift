//
//  DummyData.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/05/06.
//

import Foundation

var height: Int = 177
var weight: Int = 70
var name: String = "이충수"
var age: Int = 68
var wheelSize: Double = 0.58

var nowLocation: CLLocation?

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
}

