//
//  ViewController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/29.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    
    @IBOutlet weak var dayPushCount: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var backgroundSuperview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadUserData()
        
    }
    
    func loadImages(){
        let floorImage = UIImage(named: "바닥")
        let floorImageView = UIImageView(image: floorImage)
        floorImageView.frame = CGRect(x:0, y:backgroundSuperview.frame.height/4.0, width: backgroundSuperview.frame.width, height : backgroundSuperview.frame.height*0.75)
        backgroundSuperview.addSubview(floorImageView)
        floorImageView.backgroundColor = UIColor.clear
        
        let tileWidth = backgroundSuperview.frame.width/5
        let tileHeight = backgroundSuperview.frame.height/10
        
        let sproutImage = UIImage(named: "새싹")
        let sproutWidth = tileWidth*0.4
        let sproutHeight = tileHeight*1.2
        
        let grassImage = UIImage(named: "풀")
        let grassWidth = tileWidth*0.6
        let grassHeight = tileHeight*2
        
        let flowerImage = UIImage(named: "꽃")
        let flowerWidth = tileWidth
        let flowerHeight = tileHeight*1.5
        
        let seedlingImage = UIImage(named: "작은 나무")
        let seedlingWidth = tileWidth
        let seedlingHeight = tileHeight*3
        
        let treeImage = UIImage(named: "큰 나무")
        let treeWidth = tileWidth*1.5
        let treeHeight = tileHeight*4.5
        
        let plantImageViews = [
            UIImageView(), UIImageView(), UIImageView(),
            UIImageView(), UIImageView(), UIImageView(),
            UIImageView(), UIImageView(), UIImageView(),
            UIImageView(), UIImageView(), UIImageView(),
            UIImageView(), UIImageView(), UIImageView(),
            UIImageView(), UIImageView(), UIImageView(),
            UIImageView(), UIImageView(), UIImageView(),
            UIImageView(), UIImageView(), UIImageView(),
            UIImageView(), UIImageView(), UIImageView(),
            UIImageView(), UIImageView(), UIImageView(),
        ]
        //첫 줄
        plantImageViews[0].frame = CGRect(x: tileWidth*2.5 - treeWidth/2.0, y:0, width: treeWidth, height: treeHeight)
        plantImageViews[0].image = treeImage
        //둘째 줄
        plantImageViews[1].frame = CGRect(x: tileWidth*2.0 - seedlingWidth/2.0 - 20, y:tileHeight + treeHeight - seedlingHeight - 20, width: seedlingWidth, height: seedlingHeight)
        plantImageViews[2].frame = CGRect(x: tileWidth*3.0 - flowerWidth/2.0 - 135, y:tileHeight + treeHeight - seedlingHeight + 100, width: flowerWidth, height: flowerHeight)
        
        plantImageViews[1].image = seedlingImage
        plantImageViews[2].image = flowerImage
        //셋째 줄
        plantImageViews[3].frame = CGRect(x: tileWidth*1.5 - grassWidth/2.0 - 80, y:tileHeight*2.0 + treeHeight - seedlingHeight + 5, width: grassWidth, height: grassHeight)
        plantImageViews[4].frame = CGRect(x: tileWidth*2.5 - sproutWidth/2.0 - 113, y:tileHeight*2.0 + treeHeight - seedlingHeight + 20, width: sproutWidth, height: sproutHeight)
        plantImageViews[5].frame = CGRect(x: tileWidth*3.5 - seedlingWidth/2.0 - 130, y:tileHeight*2.0 + treeHeight - seedlingHeight + 20, width: grassWidth, height: grassHeight)
        
        plantImageViews[3].image = grassImage
        plantImageViews[4].image = sproutImage
        plantImageViews[5].image = grassImage
        
        for i in 0...5 {
            backgroundSuperview.addSubview(plantImageViews[i])
        }
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
        
    }
    

}

