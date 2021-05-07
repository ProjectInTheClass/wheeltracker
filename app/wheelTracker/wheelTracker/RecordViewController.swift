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
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month && nowCalendar.day == dataCalendar.day{
            return true
        }
        else{
            return false
        }
    }.map{
        $0.createdAt
    }
    
    let calorieOfMonth = pushDatas.filter{
        let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month && nowCalendar.day == dataCalendar.day{
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
        
        setChart(dataPoint:day, values: calorieOfMonth, name: "걸음수")
    
    }
    
    
    
    class toString{
        func toString(a:Date)->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            return dateFormatter.string(from: a)
        }
    }
    
    func setChart(dataPoint: [Date], values: [Double], name: String){
        //데이터 생성
        var lineChartEntries = [ChartDataEntry]()
        
        // char data entry에 데이터 추가

        for i in 0..<dataPoint.count{
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
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: String(day))
        lineChartView.rightAxis.enabled = false
        
        lineChartView.xAxis.setLabelCount(dataPoint.count, force: true)
        
        
        
    }
    
    
    @IBAction func showLineChart(_ sender: UIButton) {
        
    
    }
    @IBAction func selectValue(_ sender: UIButton) {
        
        if let buttonTitle = sender.titleLabel?.text {
            setChart(dataPoint:day, values: calorieOfMonth, name: buttonTitle)
        }
    }
    
    
    
    


}
