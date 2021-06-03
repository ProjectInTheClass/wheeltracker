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
    PushData(createdAt : Date(), distance : 1800, duration : 60*15),
    PushData(createdAt : Date(timeIntervalSinceNow: -60*60*24), distance : 3600, duration : 60*30),
    PushData(createdAt : Date(timeIntervalSinceNow: -60*60*24*2), distance : 3600*2, duration : 60*30*2),
    PushData(createdAt : Date(timeIntervalSinceNow: -60*60*24*3), distance : 3600*3, duration : 60*30*3),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 4), distance: 1800, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 5), distance: 1800*2, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 6), distance: 1800*3, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 7), distance: 1800*4, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 8), distance: 1800*5, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 9), distance: 1800*6, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 10), distance: 1500, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 11), distance: 1500*2, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 12), distance: 1500*3, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 13), distance: 1500*4, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 14), distance: 1500*5, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 15), distance: 1600, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 16), distance: 1600*2, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 17), distance: 1600*3, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 18), distance: 1600*4, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 19), distance: 1600*5, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 20), distance: 1700, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 21), distance: 1700*2, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 22), distance: 1700*3, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 23), distance: 1700*4, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 24), distance: 1700*5, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 25), distance: 1700*6, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 26), distance: 1000, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 27), distance: 1000*2, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 28), distance: 1000*3, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 29), distance: 1000*4, duration: 60 * 30),
    PushData(createdAt: Date(timeIntervalSinceNow: -86400 * 30), distance: 1000*5, duration: 60 * 30),
]
