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
    @IBOutlet weak var monthPushCount: UILabel!
    @IBOutlet weak var backgroundSuperview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadUserData()
        
    }
    
    func loadImages(){
        let floorImage = UIImage(named: "바닥")
        let floorImageView = UIImageView(image: floorImage)
        floorImageView.frame = CGRect(x:0, y:0, width: 400, height : 300)
        backgroundSuperview.addSubview(floorImageView)
    }
    
    func loadUserData (){
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
        
        loadImages()
        
        dayPushCount.text = String(todayData[0].pushCount)
        distance.text = String(Int(todayData[0].distance)) + "m"
        calories.text = String(todayData[0].calorie) + "kcal"
        duration.text = String(Int(todayData[0].duration/60)) + "m" + String(Int(todayData[0].duration)%60) + "s"
        
        let monthDataCounts = pushDatas.filter{
            let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
            if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month {
                return true
            }
            else{
                return false
            }
        }.reduce(0){
            $0+$1.pushCount
        }
        monthPushCount.text = String(monthDataCounts)
    }
    

}

