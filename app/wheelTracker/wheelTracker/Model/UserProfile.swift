import Foundation
import CoreLocation

var height: Int = 177
var weight: Int = 70
var name: String = "이충수"
var age: Int = 68
var wheelSize: Double = 0.58
var dmesg: String = "distance"
var nowLocation: CLLocation?
let distanceEvent = EventManager()
var unitDistance: Double = wheelSize * 6.28
