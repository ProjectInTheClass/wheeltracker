//
//  ViewController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/29.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var dayPushCount: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var duration: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let todayData = pushDatas.filter{
            let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
            if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month && nowCalendar.day == dataCalendar.day{
                return true
            }
            else{
                return false
            }
        }
        dayPushCount.text = String(todayData[0].pushCount)
        distance.text = String(Int(todayData[0].distance)) + "m"
        calories.text = String(todayData[0].calorie) + "kcal"
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        duration.text = String(Int(todayData[0].duration/60)) + ":" + String(Int(todayData[0].duration)%60)
        
    }


}

