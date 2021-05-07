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
    var day = pushDatas.filter{
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
    
    var calorieOfMonth = pushDatas.filter{
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
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lineChartView.noDataText = "데이터가 없습니다."
        lineChartView.noDataFont = .systemFont(ofSize: 20)
        lineChartView.noDataTextColor = .lightGray
        
        let dayString = day.map{
            dateToString(date: $0)
        }
        setChart(dataPoint:dayString, values: calorieOfMonth, name: "걸음수")
        
    

    
    }
    
    func dateToString(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
    
    
    func setChart(dataPoint: [String], values: [Double], name: String){
        //데이터 생성
        var lineChartEntries = [ChartDataEntry]()
        
        let dayString = day.map{
            dateToString(date: $0)
        }
        
        // char data entry에 데이터 추가
        print(calorieOfMonth)

        for i in 0..<calorieOfMonth.count{
            print(i, Double(i))
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(calorieOfMonth[i]))
        
            lineChartEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: lineChartEntries, label:name)
        //차트색
        chartDataSet.colors = [NSUIColor.blue]
        //데이터 삽입
        let data = LineChartData()
        data.addDataSet(chartDataSet)
        lineChartView.data = data
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dayString)
        print(dayString)
        lineChartView.rightAxis.enabled = false
        
        lineChartView.xAxis.setLabelCount(dataPoint.count, force: true)
        
        
        
    }
    
    
    @IBAction func showLineChart(_ sender: UIButton) {
        
 
        
        //setChart(dataPoint:dayString, values: calorieOfMonth, name: "걸음수")
        
    
    }
    @IBAction func selectValue(_ sender: UIButton) {
        
        if let buttonTitle = sender.titleLabel?.text {
          //  setChart(dataPoint:dayString, values: calorieOfMonth, name: "걸음수")
        }
    }
    
    
    
    


}
