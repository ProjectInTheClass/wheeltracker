//
//  RecordViewController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/30.
//

import UIKit
import Charts

class RecordViewController: UIViewController {

    @IBOutlet var lineChartView: LineChartView!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var stepsButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var kalButton: UIButton!
    @IBOutlet weak var time: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // createdAt, distance, duration, pushCount, calorie
    
    
    
    // 가로축. 그냥 day들이 쭉 나오는거. 한번에 몇개? 다 할순 없어. 갯수로 잘라야할듯 오늘 ~ 15개 정도
    
    var dayAxis = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
        let nowCalendar = Date()
     
        let dataCalendar = $0.createdAt
    
        if Calendar.current.ordinality(of: .day, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .day, in: .year, for: dataCalendar)! < 7{
            return true
        }else {
            return false
        }
    }.map{
        $0.createdAt
    }
    
    var day = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
        let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month {
            return true
        }
        else{
            return false
        }
    }.map{
        $0.createdAt
    }
    
    var week = pushDatas.sorted(by:{$0.createdAt < $1.createdAt}).filter{let nowCalendar = Calendar.current.dateComponents([.year, .month, .weekOfMonth], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .weekOfMonth], from: $0.createdAt)
        
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month && nowCalendar.weekOfMonth == dataCalendar.weekOfMonth{
            return true
        }
        else{
            return false
        }
    }.map{ (v:PushData)-> (Int) in
        
        let dataCalendar = Calendar.current.dateComponents([.month, .weekOfMonth], from: v.createdAt)
        
        if(dataCalendar.weekOfMonth != nil){
            return dataCalendar.weekOfMonth!
        }
        return 0

        
    }
    
    
    
    var month = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    //ToDo : 각 날짜의 달을 받아와서 같은 달이면 값을 더해야해 어떻게 해야할까?
    
    var selectedValues = [Double]()
    var selectedshow = [String]()


    var calorieOfMonth = pushDatas.sorted(by:{$0.createdAt > $1.createdAt}).filter{
        
        let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month {
            return true
        }
        else{
            return false
        }
    }.map{
        $0.calorie
    }
    
    var distanceOfMonth = pushDatas.sorted(by:{$0.createdAt > $1.createdAt}).filter{
        
        let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month {
            return true
        }
        else{
            return false
        }
    }.map{
        $0.distance
    }
    
    var durationOfMonth = pushDatas.sorted(by:{$0.createdAt > $1.createdAt}).filter{
        
        let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month {
            return true
        }
        else{
            return false
        }
    }.map{
        $0.duration
    }
    var pushCountOfMonth = pushDatas.sorted(by:{$0.createdAt > $1.createdAt}).filter{
        
        let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month {
            return true
        }
        else{
            return false
        }
    }.map{
        $0.pushCount
    }.map{
        Double($0)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.noDataText = "데이터가 없습니다."
        lineChartView.noDataFont = .systemFont(ofSize: 20)
        lineChartView.noDataTextColor = .lightGray
        
        selectedValues = pushCountOfMonth
        
        let dayString = day.map{
            dayToString(date: $0)
        }
        selectedshow = dayString
        

    }
    
    
    
    func dayToString(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
    
    func weekToString(week: Int) -> String{
        
        let nowCalendar = Calendar.current.dateComponents([.month], from: Date())
        var returnString = ""

        returnString = String(nowCalendar.month!) + "월" + String(week) + "째주"
     
        
        return returnString
        
    }
    

    
    
    func setChart(dataPoint: [String], values: [Double], name: String){
        //데이터 생성
        var lineChartEntries = [ChartDataEntry]()
        
        //selectedValues = selectedValues[0...dataPoint.count]
        print("sorted and count", selectedValues)

        for i in 0..<dataPoint.count{

            let dataEntry = ChartDataEntry(x: Double(i), y: Double(selectedValues[i]))
        
            lineChartEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: lineChartEntries, label:name)
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        lineChartView.doubleTapToZoomEnabled = false
        
        //차트색
        chartDataSet.colors = [NSUIColor.blue]
        //데이터 삽입
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChartView.data = chartData
        
        //x축 레이블 위치 수정
        lineChartView.xAxis.labelPosition = .bottom
        //x축 레이블 포맷 지정
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoint)
        lineChartView.rightAxis.enabled = false
        
        lineChartView.xAxis.setLabelCount(dataPoint.count, force: true)
        
        
        
    }
        
    
    @IBAction func showLineChart(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Day"{
            let dayString = dayAxis.map{
                dayToString(date: $0)
            }
            selectedshow = dayString
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
            
        } else if sender.titleLabel?.text == "Week"{
            
            let weekString = week.map{
                weekToString(week: $0)
            }
            selectedshow = weekString
 
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
            
        } else if sender.titleLabel?.text == "Month"{

            
            selectedshow = month
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
            
        }
        
        
        
    
    }
    @IBAction func selectValue(_ sender: UIButton) {
        if sender.titleLabel?.text == "걸음수"{
            selectedValues = pushCountOfMonth
            setChart(dataPoint: selectedshow, values: selectedValues, name:"")
            
        }else if sender.titleLabel?.text == "거리"{
            selectedValues = distanceOfMonth
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
        }else if sender.titleLabel?.text == "칼로리"{
            selectedValues = calorieOfMonth
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
        }else if sender.titleLabel?.text == "시간"{
            selectedValues = durationOfMonth
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
        }
        
    }
}
