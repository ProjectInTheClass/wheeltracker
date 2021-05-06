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
    var day = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var steps = [2000, 1000, 300, 500, 600, 1400, 2000, 1500, 800, 900]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.noDataText = "데이터가 없습니다."
        lineChartView.noDataFont = .systemFont(ofSize: 20)
        lineChartView.noDataTextColor = .lightGray
        
        setChart(dataPoint:day, values: steps, name: "걸음수")
    
    }
    
    func setChart(dataPoint: [Int], values: [Int], name: String){
        //데이터 생성
        var lineChartEntries = [ChartDataEntry]()
        
        // char data entry에 데이터 추가

        for i in 0..<dataPoint.count{
            print(i, Double(i))
            let dataEntry = ChartDataEntry(x: Double(day[i]), y: Double(steps[i]))
        
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
        lineChartView.rightAxis.enabled = false
        
        lineChartView.xAxis.setLabelCount(dataPoint.count, force: true)
        
        
    }
    
    
    @IBAction func showLineChart(_ sender: UIButton) {
        
    
    }
    @IBAction func selectValue(_ sender: UIButton) {
        
        if let buttonTitle = sender.titleLabel?.text {
            setChart(dataPoint:day, values: steps, name: buttonTitle)
        }
    }
    
    
    
    


}
