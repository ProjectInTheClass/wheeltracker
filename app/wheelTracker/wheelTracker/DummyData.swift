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

struct PushData {
    var createdAt: Date
    var distance: Double
    var duration: TimeInterval
    var pushCount: Int{
        return Int(distance / (wheelSize * 6.28))
    }
    var calorie: Double{
        return distance * 0.075
    }
}

var pushDatas = [
    PushData(createdAt : Date(), distance : 1800, duration : 60*15),
    PushData(createdAt : Date(timeIntervalSinceNow: 60*60*24), distance : 3600, duration : 60*30),
    PushData(createdAt : Date(timeIntervalSinceNow: 60*60*24*2), distance : 3600*2, duration : 60*30*2),
    PushData(createdAt : Date(timeIntervalSinceNow: 60*60*24*3), distance : 3600*3, duration : 60*30*3),
]


