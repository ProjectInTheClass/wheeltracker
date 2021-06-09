//
//  ViewController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/29.
//

import UIKit
import CoreLocation
import HealthKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    // 위치
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var dayPushCount: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var backgroundSuperview: UIView!
    
    var nowDistance = pushDatas[pushDatas.count-1].distance {didSet{loadUserData()}}
    //let healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
                
        // Do any additional setup after loading the view.
        
      /*  let healthKitTypes: Set = [
                // access push count
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.pushCount)!
    
            
            ]
            healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (_, _) in
                print("authorized???")
                
            }
            healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (bool, error) in
                if let e = error {
                    print("oops something went wrong during authorisation \(e.localizedDescription)")
                    
                } else {
                    print("User has completed the authorization flow")
                    self.getTodayPushes(completion: { (step) in
                        print(step)
                    })
            
                }
                
            }
            /*if HKHealthStore.isHealthDataAvailable() {
                let authorizationStatus = healthStore.authorizationStatus(for: .workoutType())
                if authorizationStatus == .notDetermined {
                    enableHealthKitButton.isHidden = false
                    
                } else if authorizationStatus == .sharingDenied {
                    messageLabel.isHidden = false
                    messageLabel.text = "Meditations doesn't have access to your workout data. You can enable access in the Settings application."         }
                    
            } else{
                messageLabel.isHidden = false
                messageLabel.text = "HealthKit is not available on this device."
            }*/*/
        initPushDatas()
        authorizeHealthKit()
        loadUserData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations[locations.count-1]
        if let previousLocation = nowLocation {
            let unitDistance = location.distance(from: previousLocation)
            if(pushDatas[pushDatas.count-1].createdAt.isInToday){
                pushDatas[pushDatas.count-1].distance += unitDistance
                nowDistance = pushDatas[pushDatas.count-1].distance
                //print(pushDatas[pushDatas.count-1].distance)
                //print(pushDatas[pushDatas.count-1].createdAt)
            }
            
        }
        nowLocation = locations[locations.count-1]
        distanceEvent.trigger(eventName: "distance", information: "distance has been changed!")
    }
    
    private func authorizeHealthKit() {
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            guard authorized else {
                let baseMessage = "HealthKit Authorization Failed"
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                    
                } else {
                    print(baseMessage)
                }
                return
            }
            print("HealthKit Successfully Authorized.")
        }
    }
    /*func getTodayPushes(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .pushCount)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            guard let result = result,
                  let sum = result.sumQuantity()
            else {
                print("Failed to fetch steps = \(error?.localizedDescription ?? "N/A")")
                completion(0.0)
                return
                
            }
            DispatchQueue.main.async{
                completion(sum.doubleValue(for: HKUnit.count()))
                
            }
        }
        healthStore.execute(query)
    }*/
    
    func insertImage(view:UIImageView, imageIdentifier:String, seedX: CGFloat, seedY: CGFloat){
        let tileWidth = backgroundSuperview.frame.width/10
        let tileHeight = backgroundSuperview.frame.height/10
        
        let sproutImage = UIImage(named: "sprout")
        let sproutWidth = tileWidth*0.8
        let sproutHeight = tileHeight*1.2
        
        let grassImage = UIImage(named: "grass")
        let grassWidth = tileWidth*1.2
        let grassHeight = tileHeight*2
        
        let flowerImage = UIImage(named: "flower")
        let flowerWidth = tileWidth*2
        let flowerHeight = tileHeight*1.5
        
        let seedlingImage = UIImage(named: "seedling")
        let seedlingWidth = tileWidth*1.5
        let seedlingHeight = tileHeight*2.25
        
        let treeImage = UIImage(named: "tree")
        let treeWidth = tileWidth*2
        let treeHeight = tileHeight*3
        
        var objectWidth, objectHeight, objectX, objectY:CGFloat
        var image:UIImage?
        
        switch imageIdentifier {
        case "sprout":
            objectWidth = sproutWidth
            objectHeight = sproutHeight
            objectX = seedX - sproutWidth/2.0
            objectY = seedY - sproutHeight
            image = sproutImage
        case "grass":
            objectWidth = grassWidth
            objectHeight = grassHeight
            objectX = seedX - grassWidth/2.0
            objectY = seedY - grassHeight
            image = grassImage
        case "flower":
            // flower은 다른 것들보다 조금 더 아래로 내려야 정상적인 위치가 됨
            objectWidth = flowerWidth
            objectHeight = flowerHeight
            objectX = seedX - flowerWidth/2.0
            objectY = seedY - flowerHeight*0.8
            image = flowerImage
        case "seedling":
            objectWidth = seedlingWidth
            objectHeight = seedlingHeight
            objectX = seedX - seedlingWidth/2.0
            objectY = seedY - seedlingHeight
            image = seedlingImage
        case "tree":
            objectWidth = treeWidth
            objectHeight = treeHeight
            objectX = seedX - treeWidth/2.0
            objectY = seedY - treeHeight
            image = treeImage
        default:
            objectWidth = sproutWidth
            objectHeight = sproutHeight
            objectX = seedX - sproutWidth/2.0
            objectY = seedY - sproutHeight
            image = sproutImage
        }
        view.frame = CGRect(x: objectX, y: objectY, width: objectWidth, height: objectHeight)
        view.image = image
    }
    
    func loadImages(){
        for view in backgroundSuperview.subviews{
            view.removeFromSuperview()
        }
        let floorImage = UIImage(named: "floor")
        let floorImageView = UIImageView(image: floorImage)
        floorImageView.frame = CGRect(x:0, y:backgroundSuperview.frame.height/4.0, width: backgroundSuperview.frame.width, height : backgroundSuperview.frame.height*0.75)
        backgroundSuperview.addSubview(floorImageView)
        floorImageView.backgroundColor = UIColor.clear
        
        let tileWidth = backgroundSuperview.frame.width/10
        let tileHeight = backgroundSuperview.frame.height/10
        
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
        
        //위쪽 여백을 tileHeight*3으로 가정, 한 줄 간격을 tileHeight*0.5로 가정
        let seedCoordinates = [
            (tileWidth*5.0, tileHeight*3.5),
            (tileWidth*4.0, tileHeight*4), (tileWidth*6.0, tileHeight*4),
            (tileWidth*3, tileHeight*4.5), (tileWidth*5, tileHeight*4.5), (tileWidth*7, tileHeight*4.5),
            (tileWidth*2, tileHeight*5), (tileWidth*4, tileHeight*5), (tileWidth*6, tileHeight*5), (tileWidth*8, tileHeight*5),
            (tileWidth*1, tileHeight*5.5), (tileWidth*3, tileHeight*5.5), (tileWidth*5, tileHeight*5.5), (tileWidth*7, tileHeight*5.5), (tileWidth*9, tileHeight*5.5),
            (tileWidth*1, tileHeight*6), (tileWidth*3, tileHeight*6), (tileWidth*5, tileHeight*6), (tileWidth*7, tileHeight*6), (tileWidth*9, tileHeight*6),
            (tileWidth*2, tileHeight*6.5), (tileWidth*4, tileHeight*6.5), (tileWidth*6, tileHeight*6.5), (tileWidth*8, tileHeight*6.5),
            (tileWidth*3, tileHeight*7), (tileWidth*5, tileHeight*7), (tileWidth*7, tileHeight*7),
            (tileWidth*4.0, tileHeight*7.5), (tileWidth*6.0, tileHeight*7.5),
            (tileWidth*5.0, tileHeight*8),
        ]
        
        let imageIdentifiers = ["sprout", "grass", "flower", "seedling", "tree"]
        
        let monthPushDatas = pushDatas.filter{
            return $0.createdAt.isInThisMonth
        }
        for i in 0..<monthPushDatas.count {
            var imageIndex = monthPushDatas[i].pushCount/1000
            if(imageIndex > 4){
                imageIndex = 4
            }
            insertImage(view: plantImageViews[i], imageIdentifier: imageIdentifiers[imageIndex], seedX: seedCoordinates[i].0, seedY: seedCoordinates[i].1)
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
        calories.text = String(Int(todayData[0].calorie)) + "kcal"
        duration.text = String(Int(todayData[0].duration/60)) + "m" + String(Int(todayData[0].duration)%60) + "s"
        
    }
    

}
