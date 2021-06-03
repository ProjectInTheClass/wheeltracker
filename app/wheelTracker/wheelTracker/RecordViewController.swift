//
//  RecordViewController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/30.
//

import UIKit
import Charts

class RecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pushDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = String(pushDatas[indexPath.row].calorie)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    @IBOutlet var lineChartView: LineChartView!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var stepsButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var kalButton: UIButton!
    @IBOutlet weak var time: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    
    // createdAt, distance, duration, pushCount, calorie
    
    
    
    // 가로축. x, y, z
    
    var dayAxis = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
        let nowCalendar = Date()
     
        let dataCalendar = $0.createdAt
    
     
        if Calendar.current.ordinality(of: .day, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .day, in: .year, for: dataCalendar)! < 7 {
            return true
        } else {
            return false
        }
    
    }.map{
        $0.createdAt
        
    }
    
    var weekAxis = pushDatas.sorted(by:{$0.createdAt < $1.createdAt}).filter{
        let nowCalendar = Date()
        
     
        let dataCalendar = $0.createdAt
        
        
        if Calendar.current.ordinality(of: .weekOfYear, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .weekOfYear, in: .year, for: dataCalendar)! < 5 {
            return true
        } else {
            return false
        }
    
    }.map{ (v:PushData)-> (Int?, Int?, Int?) in
        
        let dataCalendar = Calendar.current.dateComponents([.month, .weekOfYear, .weekOfMonth], from: v.createdAt)
        
        if(dataCalendar.weekOfYear != nil && dataCalendar.weekOfMonth != nil && dataCalendar.month != nil){
            return (dataCalendar.weekOfYear!, dataCalendar.weekOfMonth, dataCalendar.month)
        }
        return (0, 0, 0)

    }
    
    var monthAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    
    //data들
    
    var day = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
        let nowCalendar = Date()
        
     
        let dataCalendar = $0.createdAt
        
     
        if Calendar.current.ordinality(of: .day, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .day, in: .year, for: dataCalendar)! < 5 {
            return true
        } else {
            return false
        }
    
    }.map{
        $0
    }
    
    
    var week = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
        let nowCalendar = Date()
        
     
        let dataCalendar = $0.createdAt
        
     
        if Calendar.current.ordinality(of: .weekOfYear, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .weekOfYear, in: .year, for: dataCalendar)! < 5 {
            return true
        } else {
            return false
        }
    
    }.map{
        $0
    }
    
    var month = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
        let nowCalendar = Date()
        
     
        let dataCalendar = $0.createdAt
        
     
        if Calendar.current.ordinality(of: .month, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .month, in: .year, for: dataCalendar)! < 12 {
            return true
        } else {
            return false
        }
    
    }.map{
        $0
    }
    
    
   
    
    //ToDo : 각 날짜의 달을 받아와서 같은 달이면 값을 더해야해 어떻게 해야할까?
    
    var selectedValues = [Double]()
    var selectedshow = [String]()


    var calorieOfDay = pushDatas.sorted(by:{$0.createdAt > $1.createdAt}).filter{
        
        let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month {
            return true
        }
        else{
            return false
        }
    }.map{
        ($0.calorie, $0.createdAt)
    }
    
    
    var distanceOfDay = pushDatas.sorted(by:{$0.createdAt > $1.createdAt}).filter{
        
        let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month {
            return true
        }
        else{
            return false
        }
    }.map{
        ($0.distance, $0.createdAt)
    }
    
    var durationOfDay = pushDatas.sorted(by:{$0.createdAt > $1.createdAt}).filter{
        
        let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month {
            return true
        }
        else{
            return false
        }
    }.map{
        ($0.duration, $0.createdAt)
    }
    var pushCountOfDay = pushDatas.sorted(by:{$0.createdAt > $1.createdAt}).filter{
        
        let nowCalendar = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let dataCalendar = Calendar.current.dateComponents([.year, .month, .day], from: $0.createdAt)
        if nowCalendar.year == dataCalendar.year && nowCalendar.month == dataCalendar.month {
            return true
        }
        else{
            return false
        }
    }.map{
        (Double($0.pushCount), $0.createdAt)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.noDataText = "데이터가 없습니다."
        lineChartView.noDataFont = .systemFont(ofSize: 20)
        lineChartView.noDataTextColor = .lightGray
        
        selectedValues = pushCountOfDay.map{
            i in i.0
        }
        
        let dayString = dayAxis.map{
            dayToString(date: $0)
        }
        selectedshow = dayString
        
        //table view
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        

    }
    
    
    
    func dayToString(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
    
    func weekToString(now: (Int?, Int?, Int?)) -> String{
        
        
        
        //let nowCalendar = Calendar.current.dateComponents([.month], from: Date())
        var returnString = ""
        
        returnString = String(now.2!) + "." + String(now.1!) + "주"
     
        
        return returnString
        
    }
    

    
    func setChart(dataPoint: [String], values: [Double], name: String){
        //데이터 생성
        var lineChartEntries = [ChartDataEntry]()
        
        //selectedValues = selectedValues[0...dataPoint.count]


        for i in 0..<values.count{

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
            print("day : ", day)
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
            
        } else if sender.titleLabel?.text == "Week"{
            

            let weekString = weekAxis.map{i in
                
                weekToString(now: i)
            }
            let noDup = Set(weekString)
            selectedshow = Array(noDup).sorted()
            //selectedshow = weekAxis
            print("week : ", week)
            
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
            
        } else if sender.titleLabel?.text == "Month"{

            
            selectedshow = monthAxis
            //selectedshow = monthAxis
            print("month : ", month)
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
            
        }
        
        
        
    
    }
    @IBAction func selectValue(_ sender: UIButton) {
        if sender.titleLabel?.text == "걸음수"{

            selectedValues = pushCountOfDay.map{
                i in i.0
            }
            
            setChart(dataPoint: selectedshow, values: selectedValues, name:"")
            
        }else if sender.titleLabel?.text == "거리"{
            selectedValues = distanceOfDay.map{
                i in i.0
            }
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
        }else if sender.titleLabel?.text == "칼로리"{
            selectedValues = calorieOfDay.map{
                i in i.0
            }
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
        }else if sender.titleLabel?.text == "시간"{
            selectedValues = durationOfDay.map{
                i in i.0
            }
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
        }
        
    }
}
